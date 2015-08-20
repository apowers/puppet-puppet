# == Class: puppet
#
# This class installs the puppet package, configuration, and agent using
# reasonable defaults.
#
# === Parameters
#
# See README.md
#
# === Authors
#
# Atom Powers <atom.powers@gmail.com>
#
class puppet (
  $package_name       = $puppet::params::agent_package_name,
  $package_ensure     = 'installed',
  $service_name       = $puppet::params::agent_service_name,
  $service_ensure     = 'running',
  $service_enable     = true,
  $config_options     = {},
  $sysconfig_options  = {},
  $config_file        = $puppet::params::config_file,
  $sysconfig_file     = $puppet::params::sysconfig_file,
) inherits puppet::params {

  anchor { '::puppet::start': } ->
  class { '::puppet::package': } ->
  class { '::puppet::config':  } ~>
  class { '::puppet::service': } ->
  anchor { '::puppet::end': }

}
