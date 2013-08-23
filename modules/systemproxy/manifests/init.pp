# == Class: systemproxy
#
class systemproxy
  # Fragments to add to the concated filed
  # Edit the environment-proxy file to add changes.
  concat::fragment{ 'systemproxy':
    content => template('systemproxy/systemproxy.erb'),
    target  => environment,
    order   => 15,
  }
}
