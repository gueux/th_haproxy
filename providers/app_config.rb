use_inline_resources if defined?(use_inline_resources)

def whyrun_supported?
  true
end

action :create do
  set_updated { install_th_haproxy_app_config }
end

def install_th_haproxy_app_config
  app_config = ::File.join(new_resource.config_directory, new_resource.name)
  template "#{app_config}" do
    source new_resource.conf_template_source
    owner "root"
    group "root"
    mode 00644
    variables(
      :cluster_name => new_resource.cluster_name,
      :defaults_mode => defaults_mode,
      :defaults_retries => defaults_retries,
      :defaults_options => defaults_options,
      :defaults_timeouts => defaults_timeouts,
      :balance_algorithm => balance_algorithm
    )
  end
end

def defaults_options
  options = ( node['th_haproxy']['defaults_options'] ) ? node['th_haproxy']['defaults_options'].dup : node['haproxy']['defaults_options'].dup
  if node['haproxy']['x_forwarded_for']
    options.push("forwardfor")
  end
  return options.uniq
end

def defaults_timeouts
  node['th_haproxy']['defaults_timeouts'] || node['haproxy']['defaults_timeouts']
end

def defaults_mode
  node['th_haproxy']['defaults_mode'] || node['haproxy']['mode']
end

def defaults_retries
  node['th_haproxy']['defaults_retries'] || node['haproxy']['defaults_retries']
end

def balance_algorithm
  node['th_haproxy']['balance_algorithm'] || node['haproxy']['balance_algorithm']
end

def set_updated
  r = yield
  new_resource.updated_by_last_action(r.updated_by_last_action?)
end
