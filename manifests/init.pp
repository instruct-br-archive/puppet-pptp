# Manage pptp and connections
#
# @summary Manage pptp and connections
#
# @example
#   include pptp
class pptp (
  String                                                        $package_name,
  Boolean                                                       $package_manage  = true,
  Boolean                                                       $module_manage   = true,
  Boolean                                                       $firewall_manage = false,
  Array[
    Struct[
      {
        name     => String,
        ip       => String,
        route    => String,
        username => String,
        password => String,
        running  => Boolean,
        enable   => Boolean,
      }
    ]
  ]                                                             $connections     = [],
  Enum['present','installed','absent','purged','held','latest'] $package_ensure  = 'latest',
  String                                                        $options_file    = '/etc/ppp/options.pptp',
) {
  include pptp::install
  include pptp::service
  include pptp::connections
  Class['pptp::install']
  -> Class['pptp::service']
  -> Class['pptp::connections']
}
