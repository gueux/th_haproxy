use_inline_resources if defined?(use_inline_resources)

def whyrun_supported?
  true
end

action :create do
  set_updated { create_haproxy_etc_directory }
  set_updated { install_th_haproxy_global_config }
end

def create_haproxy_etc_directory
  directory new_resource.config_directory do
    recursive true
  end
end

def install_th_haproxy_global_config
  partial_conf_dir = ::File.join(new_resource.config_directory)
  template "#{partial_conf_dir}/#{new_resource.name}" do
    source new_resource.conf_template_source
    owner "root"
    group "root"
    mode 00644
  end
end

def set_updated
  r = yield
  new_resource.updated_by_last_action(r.updated_by_last_action?)
end
