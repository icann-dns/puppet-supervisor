# @summary module to manage supervisord
# @url http://supervisord.org/configuration.html
class supervisor (
  Array[String[1]]                               $packages,
  String[1]                                      $service,
  Stdlib::Absolutepath                           $config_dir,
  Stdlib::Absolutepath                           $config_file,
  Stdlib::Absolutepath                           $include_dir,
  Stdlib::Absolutepath                           $logfile,
  Optional[Pattern[/\d+[KMG]B/]]                 $logfile_maxbytes,
  Optional[Integer[1]]                           $logfile_backups,
  Optional[Supervisor::Loglevel]                 $logfile_loglevel,
  Stdlib::Absolutepath                           $pidfile,
  Optional[Pattern[/^[0-7]{3,4}$/]]              $umask,
  Boolean                                        $nodaemon,
  Optional[Integer[1]]                           $minfds,
  Optional[Integer[1]]                           $minprocs,
  Optional[Boolean]                              $nocleanup,
  Stdlib::Absolutepath                           $childlogdir,
  Optional[String[1]]                            $user,
  Optional[Stdlib::Absolutepath]                 $directory,
  Optional[Boolean]                              $strip_ansi,
  Optional[Hash[String[1],String[1]]]            $environment,
  Optional[String[1]]                            $identifier,
  String[1]                                      $serverurl,
  Optional[String[1]]                            $username,
  Optional[String[1]]                            $password,
  Optional[String[1]]                            $prompt,
  Optional[Stdlib::Absolutepath]                 $history_file,
  Boolean                                        $unix_http_server_enable,
  Stdlib::Absolutepath                           $unix_http_server_file,
  Pattern[/^[0-7]{4}$/]                          $unix_http_server_chmod,
  Optional[Pattern[/\w+(:\w+)?/]]                $unix_http_server_chown,
  Optional[String[1]]                            $unix_http_server_username,
  Optional[String[1]]                            $unix_http_server_password,
  Boolean                                        $inet_http_enable,
  Stdlib::IP::Address                            $inet_http_server_ip,
  Stdlib::Port                                   $inet_http_server_port,
  Optional[String[1]]                            $inet_http_server_username,
  Optional[String[1]]                            $inet_http_server_password,
  Optional[Hash[String[1], Supervisor::Program]] $programs
) {
  ensure_packages($packages)
  file { [$config_dir, $include_dir]:
    ensure => directory,
  }
  file { $config_file:
    ensure  => file,
    content => template('supervisor/etc/supervisord.conf.erb'),
    notify  => Service[$service],
  }
  if $programs {
    $programs.each |String $program, Supervisor::Program $config| {
      file {"${include_dir}/${program}.conf":
        ensure  => file,
        content => template('supervisor/etc/conf.d/program.conf.erb'),
        notify  => Service[$service],
      }
    }
  }
  service { $service:
    ensure     => running,
    enable     => true,
    hasrestart => true,
    require    => Package[$packages],
  }
}
