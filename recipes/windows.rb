# opsmatic::windows
#  Installs and configures the Opsmatic agent and other related components

current_agent_version = ''
if ::File.exist?('C:\Program Files\Opsmatic\opsmatic-agent\opsmatic-agent.exe')
  get_version_cmd = Mixlib::ShellOut.new("\"C:\\Program Files\\Opsmatic\\opsmatic-agent\\opsmatic-agent.exe\" -version")
  get_version_cmd.run_command
  current_agent_version = get_version_cmd.stdout
end

# Get the actual build number from the configured agent version
desired_agent_version_parts = node['opsmatic']['agent_version'].split('.')
desired_agent_version = desired_agent_version_parts[2]

# Only run agent installation work if we don't have an existing agent version matching the configured version
unless current_agent_version.include? desired_agent_version
  directory 'C:\Windows\Temp\opsmatic\agent' do
    action :delete
    recursive true
    only_if { ::File.exist?('C:\Windows\Temp\opsmatic\agent') }
  end

  directory 'C:\Windows\Temp\opsmatic\agent' do
    recursive true
    action :create
  end

  windows_zipfile 'C:\Windows\Temp\opsmatic\agent' do
    source 'https://opsmatic-downloads.s3.amazonaws.com/opsmatic-agent/windows_386/opsmatic-agent_' + node['opsmatic']['agent_version'] + '_windows_386.zip'
    action :unzip
  end

  execute 'config-opsmatic-agent.exe' do
    command 'C:\Windows\Temp\opsmatic\agent\config-opsmatic-agent.exe -token ' + node['opsmatic']['integration_token']
  end
end

include_recipe 'opsmatic::file-integrity-monitoring'
include_recipe 'opsmatic::handler'
