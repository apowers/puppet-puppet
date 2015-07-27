# == Class: puppet::server::service
#
# This class starts the puppet agent service.
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
class puppet::server::service (
  $enable         = $puppet::server::service_enable,
  $ensure         = $puppet::server::service_ensure,
  $service_name   = $puppet::server::service_name,
) {

  validate_string($ensure,$service_name)
  validate_bool($enable)

  service { $service_name:
    ensure    => $ensure,
    enable    => $enable,
    subscribe => Class['puppet::server::config'],
  }

}
