# == Define: powerdns::backend

define powerdns::backend (
  $options = {},
) {
  validate_string($name)

  # Construct the backend class name.
  $backend = "::powerdns::backend::${name}"

  # If the backend doesn't exist, it's not supported.
  if defined($backend) == false {
    fail("This module does not support the ${name} backend for PowerDNS!")
  }

  # Ensure PowerDNS is installed before the backend is evaluated.
  Class['::powerdns::install'] -> Class[$backend]

  # Ensure the backend notifies PowerDNS when things change.
  Class[$backend] ~> Class['::powerdns::service']

  # Evaluate the backend with any specified options.
  $class = { "::powerdns::backend::${name}" => $options }
  create_resources('class', $class)
}
