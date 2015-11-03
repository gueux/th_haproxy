#
# Cookbook Name:: th_haproxy
# Default:: default
#
# Copyright 2010, Opscode, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

default['th_haproxy']['install_method'] = "source"
default['th_haproxy']['source']['version'] = "1.5.14"
default['th_haproxy']['source']['url'] = "http://www.haproxy.org/download/1.5/src/haproxy-1.5.14.tar.gz"
default['th_haproxy']['source']['checksum'] = "9565dd38649064d0350a2883fa81ccfe92eb17dcda457ebdc01535e1ab0c8f99"
default['th_haproxy']['source']['prefix'] = "/"
default['th_haproxy']['source']['use_openssl'] = true
default['th_haproxy']['conf_dir'] = "/etc/haproxy/"
default['th_haproxy']['main_conf'] = "/etc/haproxy/haproxy.cfg"
default['th_haproxy']['defaults_mode'] = "http"
default['th_haproxy']['defaults_retries'] = 3
default['th_haproxy']['balance_alghoritm'] = "roundrobin" 