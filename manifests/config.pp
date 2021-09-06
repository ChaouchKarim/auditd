# @summary Manage the config and rules files
#
# @api private
class auditd::config inherits auditd {


  $distfamily = downcase($facts['os']['family'])

  file { $auditd::auditd_file:
    ensure  => $auditd::auditd_file_ensure,
    content => template('auditd/auditd.conf.erb'),
    owner   => $auditd::auditd_file_owner,
    group   => $auditd::auditd_file_group,
    mode    => $auditd::auditd_file_mode,
  }



  case $distfamily {
    'Debian', 'debian','Ubuntu','ubuntu': {
        file { $auditd::auditd_rules_file:
          ensure  => $auditd::auditd_rules_file_ensure,
          content => template('auditd/audit.rules.erb'),
          owner   => $auditd::auditd_rules_file_owner,
          group   => $auditd::auditd_rules_file_group,
          mode    => $auditd::auditd_rules_file_mode,
        }
      }

    'Redhat', 'redhat': {
          file { $auditd::auditd_puppet_rules_file:
            ensure  => $auditd::auditd_rules_file_ensure,
            content => template('auditd/puppet.rules.erb'),
            owner   => $auditd::auditd_rules_file_owner,
            group   => $auditd::auditd_rules_file_group,
            mode    => $auditd::auditd_rules_file_mode,
          }
        }
      }

}
