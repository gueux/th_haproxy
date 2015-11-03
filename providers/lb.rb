use_inline_resources if defined?(use_inline_resources)

action :create do
  #While there is no way to have an include directive for haproxy
  #configuration file, this provider will only modify attributes !
  listener = []
  listener << "bind #{new_resource.bind} #{new_resource.ssl_opt if new_resource.ssl_on}" unless new_resource.bind.nil?
  listener << "reqadd X-Forwarded-Proto:\\ https" if new_resource.ssl_on
  listener << "balance #{new_resource.balance}" unless new_resource.balance.nil?
  listener << "mode #{new_resource.mode}" unless new_resource.mode.nil?

  if new_resource.params.is_a? Hash
    listener += new_resource.params.map { |k,v| "#{k} #{v}" }
  else
    listener += new_resource.params
  end

  listener += new_resource.servers.map {|server| "server #{server[:name]} #{server[:address]} check" }

  node.default['haproxy']['listeners'][new_resource.cluster_name][new_resource.type][new_resource.name] = listener
end

