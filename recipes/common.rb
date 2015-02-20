# stuff that should be included everywhere

template "/etc/default/opsmatic-global" do
  source "default-opsmatic-global.erb"
  owner "root"
  group "root"
  mode "00644"
end

# Config File for Opsmatic Agent
# https://opsmatic.com/app/docs/agent-configuration

template "/etc/opsmatic-agent.conf" do
  source "opsmatic-agent.conf.erb"
  owner "root"
  group "root"
  mode "00644"
end
