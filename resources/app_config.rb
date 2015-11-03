actions :create
default_action :create

attribute :name, :kind_of => String, :name_attribute => true
attribute :cluster_name, :kind_of => String, :required => true
attribute :config_directory, :kind_of => String, :default => '/etc/haproxy/conf.d'
attribute :conf_template_source, :kind_of => String, :default => 'app.cfg.erb'