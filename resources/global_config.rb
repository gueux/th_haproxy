actions :create
default_action :create

attribute :name, :kind_of => String, :name_attribute => true
attribute :config_directory, :kind_of => String, :default => '/etc/haproxy/conf.d'
attribute :conf_template_source, :kind_of => String, :default => 'global.cfg.erb'