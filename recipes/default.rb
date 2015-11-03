#
# Cookbook Name:: th_haproxy
# Recipe:: default
#
# Copyright 2015, R&R Innovation LLC
#

node.default['haproxy']['install_method'] = node['th_haproxy']['install_method']
node.default['haproxy']['source']['version'] = node['th_haproxy']['source']['version']
node.default['haproxy']['source']['url'] = node['th_haproxy']['source']['url']
node.default['haproxy']['source']['checksum'] = node['th_haproxy']['source']['checksum']
node.default['haproxy']['source']['use_openssl'] = node['th_haproxy']['source']['use_openssl']
node.default['haproxy']['source']['prefix'] = node['th_haproxy']['source']['prefix']
node.default['haproxy']['conf_dir'] = node['th_haproxy']['conf_dir']

include_recipe "haproxy::install_source"

apt_package 'colordiff' do
  action :install
end

cookbook_file "/etc/default/haproxy" do
  cookbook "haproxy"
  source "haproxy-default"
  owner "root"
  group "root"
  mode 00644
end

th_haproxy_global_config '00-global.cfg' do
  action :create
end