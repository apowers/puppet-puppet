# == Class: puppet::agent
#
# This class configures puppet.
# It should not be declared except through the parent class.
#
# === Parameters
#
# See README.md
#
# === Authors
#
# Atom Powers <atom.powers@gmail.com>
#
class puppet::server::config (
  $sysconfig_options  = $puppet::server::sysconfig_options,
  $sysconfig_file     = $puppet::server::sysconfig_file,
) {

  validate_hash($sysconfig_options)
  validate_absolute_path($sysconfig_file)

  $merged_sysconfig_options = merge($puppet::params::default_server_sysconfig_options, $sysconfig_options)

  file { 'puppetserver_sysconfig_file':
    ensure  => 'file',
    path    => $sysconfig_file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('puppet/sysconfig.erb'),
    require => Class['puppet::server::package'],
  }

}
