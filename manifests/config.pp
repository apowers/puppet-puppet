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
class puppet::config (
  $config_options     = $puppet::config_options,
  $sysconfig_options  = $puppet::sysconfig_options,
  $config_file        = $puppet::config_file,
  $sysconfig_file     = $puppet::sysconfig_file,
) {
  include puppet::params

  validate_hash($config_options)
  validate_hash($sysconfig_options)
  validate_absolute_path($config_file, $sysconfig_file)

  $merged_sysconfig_options = merge($puppet::params::default_sysconfig_options, $sysconfig_options)

  file { $config_file:
    ensure  => 'file',
#    path    => $config_file,
    owner   => 'puppet',
    group   => 'root',
    mode    => '0444',
    content => template('puppet/puppet.conf.erb'),
    require => Class['puppet::package'],
  }

  file { 'puppet_sysconfig_file':
    ensure  => 'file',
    path    => $sysconfig_file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('puppet/sysconfig.erb'),
    require => Class['puppet::package'],
  }

}
