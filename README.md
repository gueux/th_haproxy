th_haproxy Cookbook
===================

Wrapper for 'haproxy' cookbook to support splitted configs

Requirements
------------

#### cookbooks
- `haproxy` - th_haproxy needs original cookbook .

Attributes
----------
#### th_haproxy::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['th_haproxy']['install_method']</tt></td>
    <td>String</td>
    <td>Install method (source, package)</td>
    <td><tt>source</tt></td>
  </tr>
  <tr>
    <td><tt>['th_haproxy']['source']['version']</tt></td>
    <td>String</td>
    <td>Installation version</td>
    <td><tt>1.5.14</tt></td>
  </tr>
  <tr>
    <td><tt>['th_haproxy']['source']['url']</tt></td>
    <td>String</td>
    <td>Installation URL</td>
    <td><tt>http://www.haproxy.org/download/1.5/src/haproxy-1.5.14.tar.gz</tt></td>
  </tr>
  <tr>
    <td><tt>['th_haproxy']['source']['checksum']</tt></td>
    <td>String</td>
    <td>Source checksum</td>
    <td><tt>9565dd38649064d0350a2883fa81ccfe92eb17dcda457ebdc01535e1ab0c8f99</tt></td>
  </tr>
  <tr>
    <td><tt>['th_haproxy']['source']['prefix']</tt></td>
    <td>String</td>
    <td>Installation prefix</td>
    <td><tt>'/'</tt></td>
  </tr>
  <tr>
    <td><tt>['th_haproxy']['source']['use_openssl']</tt></td>
    <td>Boolean</td>
    <td>Whether to compile haproxy with SSL support</td>
    <td><tt>'/'</tt></td>
  </tr>
  <tr>
    <td><tt>['th_haproxy']['conf_dir']</tt></td>
    <td>String</td>
    <td>Haproxy config dir</td>
    <td><tt>'/etc/haproxy'</tt></td>
  </tr>
  <tr>
    <td><tt>['th_haproxy']['main_conf']</tt></td>
    <td>String</td>
    <td>File for join generated haproxy applications' configs</td>
    <td><tt>'/etc/haproxy/haproxy.cfg'</tt></td>
  </tr>
</table>

Usage
-----
#### th_haproxy::default

Just include `th_haproxy` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[th_haproxy]"
  ]
}
```

This install haproxy onto your machine and setup default config with "global" options

Create the 'load_balancer' recipe into your application cookbook with the creating 'th_haproxy' resources:

```
  th_haproxy_lb "frontend-#{ha_cluster_name}" do
    cluster_name ha_cluster_name
    type 'frontend'
    bind "#{bind}"
    ssl_on node['neo4j']['load_balancer']['https_enabled']
    ssl_opt "ssl crt #{node['neo4j']['load_balancer']['https_cert']}"
    params({
      'default_backend' => "backend-#{ha_cluster_name}"
    })
  end

  th_haproxy_lb "backend-#{ha_cluster_name}" do
    cluster_name ha_cluster_name
    type 'backend'
    mode 'http'
    servers servers
    params([
      "option httpchk GET /db/manage/server/ha/master"
    ])
  end

  th_haproxy_app_config "10-neo4j-#{service.name}.cfg" do
    action :create
    cluster_name "#{ha_cluster_name}"
    conf_template_source 'lb_haproxy.erb'
  end
```

Contributing
------------

1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
-------------------
Author: Ihor Savchenko
Email: ihor.s@randrmusic.com
