# opsmatic::handler
#   Installs and configures the Opsmatic report and exception handler

include_recipe 'opsmatic::common'

chef_gem 'chef-handler-opsmatic' do
  action :upgrade
  version node['opsmatic']['handler_version']
end

require 'chef/handler/opsmatic'

default_agent_dir = '/var/db/opsmatic-agent'
if node['platform_family'] == 'windows'
  default_agent_dir = 'C:\\Program Files\\Opsmatic\\opsmatic-agent'
end

chef_handler 'Chef::Handler::Opsmatic' do
  source 'chef/handler/opsmatic'
  arguments [
    :integration_token => node['opsmatic']['integration_token'],
    :collector_url     => node['opsmatic']['handler_endpoint'],
    :ssl_peer_verify   => node['opsmatic']['handler_ssl_peer_verify'],
    :timeout           => node['opsmatic']['handler_timeout'],
    :agent_dir         => default_agent_dir
  ]
  action :nothing
end.run_action(:enable)
