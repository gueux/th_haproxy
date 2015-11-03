actions :join
default_action :join

attribute :name, :kind_of => String, :name_attribute => true
attribute :join_dir, :kind_of => String, :default => '/etc/haproxy/conf.d'
attribute :result_conf, :kind_of => String, :default => '/etc/haproxy/haproxy.cfg'