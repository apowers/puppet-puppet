# == Class: puppet
#
# This class installs the puppet package, configuration, and agent using
# common sense defaults.
#
# === Parameters
#
# See README.md
#
# === Authors
#
# Atom Powers <atom.powers@gmail.com>
#
class puppet::server (
  $package_name       = $puppet::params::server_package_name,
  $package_ensure     = 'installed',
  $service_name       = $puppet::params::server_service_name,
  $service_enable     = true,
  $service_ensure     = 'running',
  $config_options     = {},
  $sysconfig_options  = {},
  $sysconfig_file     = $puppet::params::server_sysconfig_file,
) inherits puppet::params {

  anchor { '::puppet::server::start': } ->
  class { '::puppet::server::package': } ->
  class { '::puppet::server::config': } ~>
  class { '::puppet::server::service': } ->
  anchor { '::puppet::server::end': }

}
