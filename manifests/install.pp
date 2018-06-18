# Internal
#
# Installs the package
#
class pptp::install {
  if $pptp::package_manage {
    package { $pptp::package_name:
      ensure => $pptp::package_ensure,
    }

    file { '/sbin/pon':
      ensure   => 'file',
      owner    => 'root',
      group    => 'root',
      mode     => '0755',
      seluser  => 'system_u',
      selrole  => 'object_r',
      seltype  => 'usr_t',
      selrange => 's0',
      content  => template('pptp/pon.erb'),
    }

    file { '/sbin/poff':
      ensure   => 'file',
      owner    => 'root',
      group    => 'root',
      mode     => '0755',
      seluser  => 'system_u',
      selrole  => 'object_r',
      seltype  => 'usr_t',
      selrange => 's0',
      content  => template('pptp/poff.erb'),
    }
  }

  if $pptp::module_manage {
    include ::kmod
    file { '/etc/modules-load.d/pptp.conf':
      ensure   => 'file',
      owner    => 'root',
      group    => 'root',
      mode     => '0644',
      seluser  => 'unconfined_u',
      seltype  => 'etc_t',
      selrange => 's0',
      selrole  => 'object_r',
      content  => "ppp_mppe\n",
    }

    kmod::load { 'ppp_mppe': }
  }

  if $pptp::firewall_manage {
    include ::firewalld
    firewalld_direct_rule { 'Accept gre protocol':
      ensure        => present,
      inet_protocol => 'ipv4',
      table         => 'filter',
      chain         => 'INPUT',
      priority      => 0,
      args          => '-p gre -j ACCEPT',
    }
  }
}
