# == Define: powerdns::setting

define powerdns::setting (
  $value  = undef,
) {
  concat::fragment { $name:
    target  => "${::powerdns::config::config_path}/pdns.conf",
    content => "${name}=${value}\n",
  }
}
