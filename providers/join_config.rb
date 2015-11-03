use_inline_resources if defined?(use_inline_resources)

def whyrun_supported?
  true
end

action :join do
  set_updated { join_th_haproxy_configs }

  service "haproxy" do
    supports :restart => true, :status => true, :reload => true
    action [:enable, :start]
  end
end

def set_updated
  r = yield
  new_resource.updated_by_last_action(r.updated_by_last_action?)
end

def join_th_haproxy_configs
  cookbook_file "/tmp/join_ha_configs.sh" do
    source "join_ha_configs.sh"
    mode 0755
  end

  execute 'Join HAProxy configs' do
    command "/tmp/join_ha_configs.sh #{new_resource.join_dir} #{new_resource.result_conf}"
    notifies :restart, "service[haproxy]", :delayed
  end
end
