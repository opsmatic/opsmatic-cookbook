# stuff that should be included everywhere

case node['platform_family']
when 'windows'
  # Windows takes a completely separate path - a recipe which will handle everything itself.
  return
end

template '/etc/default/opsmatic-global' do
  source 'default-opsmatic-global.erb'
  owner 'root'
  group 'root'
  mode '00644'
  notifies :restart, 'service[opsmatic-agent]', :delayed
end
