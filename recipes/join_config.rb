#
# Cookbook Name:: th_haproxy
# Recipe:: join_config
#
# Copyright 2015, R&R Innovation LLC
#

th_haproxy_join_config "Join splitted config" do
  join_dir "#{node['th_haproxy']['conf_dir']}/conf.d"
  result_conf node['th_haproxy']['main_conf']
end