puppet
===

This module manager puppet agent and/or puppetserver.
It is intended to manage a puppet infrastructure after it has been installed.

It may be possible to use it to setup puppet if the right components are already
installed but that isn't a design goal.

## Classes

### puppet
This class wraps the individual puppet package, config, and service classes.

#### Parameters

Install and configure the Puppet agent.

* `package_name` - The name of the puppet agent package.
Default: `puppet`. See params.

* `package_ensure` - What state the package should be in.
Valid values are `present`, `installed`, `absent`, `purged`, `held`, `latest`.
Default: `installed`

* `service_name` - The name of the puppet agent service.
Default: `puppet`. See params.

* `service_ensure` - Whether a service should be running.
Valid values are `stopped`, `running`.
Defalut: `running`

* `service_enable` - Whether a service should be enabled to start at boot.
Valid values are `true`, `false`, `manual`.
Default: `true`

* `config_options` - A hash of options for puppet.conf. Merged with defaults in params.
This must include, at least, a value for `server`.
Default: empty

* `sysconfig_options` - A hash of options for $sysconfig_file. Merged with defaults in params.
Default: empty

* `config_file` - The location and name of the puppet.conf file.
Default: `/etc/puppet/puppet.conf`

* `sysconfig_file` - The location and name of the sysconfig file.
Default: OS dependent. See params.

### puppet::server

Install and (partially) configure Puppetserver.
TODO: Manage all the configuration files. Currently only teh sysconfig file is managed.

* `package_name` - The name of the puppetserver package.
Default: `puppetserver`. See params.

* `package_ensure` - What state the package should be in.
Valid values are `present`, `installed`, `absent`, `purged`, `held`, `latest`.
Default: `installed`

* `service_name` - The name of the puppetserver service.
Default: `puppetserver`. See params.

* `service_ensure` - Whether a service should be running.
Valid values are `stopped`, `running`.
Defalut: `running`

* `service_enable` - Whether a service should be enabled to start at boot.
Valid values are `true`, `false`, `manual`.
Default: `true`

* `sysconfig_options` - A hash of options for $sysconfig_file. Merged with defaults in params.
This is used to set option for the java JVM and other things.
Default: empty. See params.

* `sysconfig_file` - The location and name of the sysconfig file.
Default: OS dependent. See params.


## Examples
### With Hiera
    ---
    classes:
      - puppet

    puppet::config_options:
      main:
        server:       'puppet.domain.tld'
        environment:  'production'
        confdir:      '/etc/puppet'
        hiera_config: '/etc/puppet/hiera.yaml'
      master:
        node_terminus:            'exec'
        external_nodes:           '/etc/puppet/bin/node_role.rb'
        ssl_client_header:        'SSL_CLIENT_S_DN'
        ssl_client_verify_header: 'SSL_CLIENT_VERIFY'
      agent:
        pluginsync:   'true'
        report:       'true'
        runinterval:  '1800'
        splay:        'true'
        splaylimit:   '300'

    puppet::sysconfig_options:
      START:  'yes'

### Without Hiera

    $puppet_config_options = {
      'main' => {
        'server'       => 'puppet.domain.tld',
        'environment'  => 'production',
        'confdir'      => '/etc/puppet',
        'hiera_config' => '/etc/puppet/hiera.yaml',
      },
      'master' => {
        'node_terminus'            => 'exec',
        'external_nodes'           => '/etc/puppet/bin/node_role.rb',
        'ssl_client_header'        => 'SSL_CLIENT_S_DN',
        'ssl_client_verify_header' => 'SSL_CLIENT_VERIFY',
      },
      'agent' => {
        'pluginsync'  => 'true',
        'report'      => 'true',
        'runinterval' => '1800',
        'splay'       => 'true',
        'splaylimit'  => '300',
      }
    }

    puppet_sysconfig_options = {
      'START' => 'yes',
    }

    class {'::puppet':
        config_options    => $puppet_config_options,
        sysconfig_options => $puppet_sysconfig_options,
    }

## Authors
* Atom Powers <atom.powers@gmail.com>

