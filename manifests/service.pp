# == Class: puppet::agent::service
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
class puppet::service (
  $enable         = str2bool($puppet::service_enable),
  $ensure         = $puppet::service_ensure,
  $service_name   = $puppet::service_name,
) {

  validate_string($ensure,$service_name)

  service { $service_name:
    ensure    => $ensure,
    enable    => $enable,
    subscribe => Class['puppet::config'],
  }

}
