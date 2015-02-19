# This recipe will enable File Integrity monitoring for user specified files
# https://opsmatic.com/app/docs/file-integrity-monitoring
# Include an array of files paths within your attributes

# Create /var/db/opsmatic-agent/external.d/

directory "/var/db/opsmatic-agent/external.d" do 
    owner 'root'
    group 'root'
    mode "00644"
end

# Populate the directory created above with a JSON file:

# stuff that should be included everywhere

template "/var/db/opsmatic-agent/external.d/file-integrity-monitoring.json" do
    source "file-integrity-monitoring.json.erb"
    owner "root"
    group "root"
    mode "00644"
end
