# Internal
#
# Manage the service
#
class pptp::service {
  include ::systemd::systemctl::daemon_reload
  file { 'ppp.service':
    ensure   => 'file',
    path     => '/etc/systemd/system/ppp@.service',
    owner    => 'root',
    group    => 'root',
    mode     => '0644',
    seluser  => 'unconfined_u',
    seltype  => 'iptables_unit_file_t',
    selrange => 's0',
    selrole  => 'object_r',
    content  => template('pptp/service.erb'),
  }
  ~> Class['systemd::systemctl::daemon_reload']

}
