# == Class: puppet::package
#
# This class installes the puppet package.
#
# === Parameters
#
# See README.md
#
# === Authors
#
# Atom Powers <atom.powers@gmail.com>
#
class puppet::package (
  $ensure       = $puppet::package_ensure,
  $package_name = $puppet::package_name,
) inherits puppet::params {

  validate_string($ensure, $package_name)

  package { 'puppet':
    ensure => $ensure,
    name   => $package_name,
  }

}
