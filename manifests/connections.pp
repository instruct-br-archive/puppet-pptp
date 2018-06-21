# Internal
#
# Manage the client connections
#
class pptp::connections {

  file { '/etc/ppp/chap-secrets':
    ensure   => file,
    owner    => 'root',
    group    => 'root',
    mode     => '0600',
    seluser  => 'system_u',
    selrole  => 'object_r',
    seltype  => 'usr_t',
    selrange => 's0',
    content  => template('pptp/chap-secrets.epp'),
  }

  if defined('$pptp::connections') {
    $pptp::connections.each |$connection| {
      file { $connection['name']:
        ensure   => 'file',
        path     => "/etc/ppp/peers/${connection['name']}",
        owner    => 'root',
        group    => 'root',
        mode     => '0644',
        seluser  => 'unconfined_u',
        seltype  => 'pppd_etc_rw_t',
        selrange => 's0',
        selrole  => 'object_r',
        content  => template('pptp/connection.erb'),
      }

      service { $connection['name']:
        ensure => $connection['running'],
        name   => "ppp@${connection['name']}.service",
        enable => $connection['enable'],
      }
    }

    file { '/etc/ppp/ip-up.local':
      ensure   => 'file',
      owner    => 'root',
      group    => 'root',
      mode     => '0755',
      seluser  => 'unconfined_u',
      selrole  => 'object_r',
      seltype  => 'bin_t',
      selrange => 's0',
      content  => template('pptp/ip-up.local.erb'),
    }

    file { '/etc/ppp/ip-down.local':
      ensure   => 'file',
      owner    => 'root',
      group    => 'root',
      mode     => '0755',
      seluser  => 'unconfined_u',
      selrole  => 'object_r',
      seltype  => 'bin_t',
      selrange => 's0',
      content  => template('pptp/ip-down.local.erb'),
    }
  }
}
