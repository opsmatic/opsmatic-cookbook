# this should only be override or changed on advice from Opsmatic support
default[:opsmatic][:collector_url] = "https://api.opsmatic.com/webhooks/events"

# TODO: we need to work out a portable way to consistently verify certs
# in the meantime we're disabling SSL peer verification by default. You can
# check to see if your chef-client supports peer verify by setting this 
# attribute to true, and if you don't get a warning you're good to go
default[:opsmatic][:ssl_peer_verify] = false
