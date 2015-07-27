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
class puppet::server::package (
  $ensure       = $puppet::server::package_ensure,
  $package_name = $puppet::server::package_name,
) {

  validate_string($ensure, $package_name)

  package { 'puppetserver_package':
    ensure => $ensure,
    name   => $package_name,
  }

}
