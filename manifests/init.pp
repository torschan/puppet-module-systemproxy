# == Class: systemproxy
#
class environment {

  case $::osfamily {
    'RedHat': {
      include systemproxy
      $fragment = "/etc/profile.d/proxy.sh"

      concat { 'environment'
        path  => $fragment,
        owner => root,
        group => root,
        mode  => '0644',
      }
}
    'Debian': {
      include systemproxy
      $fragment = "/etc/environment"

      concat { 'environment'
        path  => $fragment, #Breaks code here while testing in vagrant, expects '}'
        owner => root,
        group => root,
        mode  => '0644',
      }

      concat::fragment{ 'environment':
        content => template('environment/path.erb'),
        target  => environment,
        order   => 1,
      }
    }
    'Suse': {
      $fragment = '/etc/sysconfig/proxy'
      include systemproxy

    concat { 'environment'
      path  => $fragment,
      owner => root,
      group => root,
      mode  => '0644',
    }

    concat::fragment{ 'environment':
      content => template('environment/susepath.erb'),
      target  => environment,
      order   => 1,
    }
}
#Need to specify what else is in the profile file before concat.
    'Solaris': {
      include systemproxy
      $fragment = "/etc/profile"
      concat { 'environment' 
        path  => $fragment,
        owner => root,
        group => root,
        mode  => '0644',
      }

      concat::fragment{ 'environment':
        content => template('environment/path.erb'),
        target  => environment,
        order   => 1,
      }
    }
    default: { fail("Unrecognized operating system")}
  }
}
