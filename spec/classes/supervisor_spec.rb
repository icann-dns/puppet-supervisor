require 'spec_helper'

describe 'supervisor' do
  let(:node) { 'foobar.example.com' }
  let(:params) { {} }

  # Puppet::Util::Log.level = :debug
  # Puppet::Util::Log.newdestination(:console)
  # This will need to get moved
  # it { pp catalogue.resources }
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) { facts }

      describe 'check default config' do
        it { is_expected.to compile.with_all_deps }
        it do
          is_expected.to contain_file('/etc/supervisor').with_ensure('directory')
        end
        it do
          is_expected.to contain_file(
            '/etc/supervisor/conf.d',
          ).with_ensure('directory')
        end
        it do
          is_expected.to contain_file(
            '/etc/supervisor/supervisord.conf',
          ).with_ensure('file').with_content(
            %r{
            \[unix_http_server\]
            \s+file\s=\s/var/run/supervisor.sock
            \s+chmod\s=\s0700
            }x,
          ).with_content(
            %r{
            \[supervisord\]
            \s+logfile\s=\s/var/log/supervisor/supervisord.log
            \s+pidfile\s=\s/var/run/supervisord.pid
            \s+nodaemon\s=\strue
            \s+childlogdir\s=\s/var/log/supervisor
            }x,
          ).with_content(
            %r{
            \[supervisorctl\]\n
            serverurl\s=\sunix:///var/run/supervisor.sock
            }x,
          ).with_content(
            %r{
            \[include\]\n
            files\s=\s/etc/supervisor/conf.d/\*.conf
            }x,
          ).without_content(
            %r{inet_http_server},
          ).without_content(
            %r{logfile_maxbytes},
          ).without_content(
            %r{logfile_backups},
          ).without_content(
            %r{logfile_loglevel},
          ).without_content(
            %r{umask},
          ).without_content(
            %r{minfds},
          ).without_content(
            %r{minprocs},
          ).without_content(
            %r{nocleanup},
          ).without_content(
            %r{user},
          ).without_content(
            %r{directory},
          ).without_content(
            %r{environment},
          ).without_content(
            %r{strip_ansi},
          ).without_content(
            %r{identifier},
          ).without_content(
            %r{username},
          ).without_content(
            %r{password},
          ).without_content(
            %r{prompt},
          ).without_content(
            %r{history_file},
          )
        end
        it do
          is_expected.to contain_service('supervisor').with(
            ensure: 'running',
            enable: true,
            hasrestart: true,
          )
        end
      end
      describe 'Change Defaults' do
        context 'packages' do
          before(:each) { params.merge!(packages: ['foobar']) }
          it { is_expected.to compile }
        end
        context 'service' do
          before(:each) { params.merge!(service: 'foobar') }
          it { is_expected.to compile }
          # Add Check to validate change was successful
        end
        context 'config_dir' do
          before(:each) { params.merge!(config_dir: '/foo/bar') }
          it { is_expected.to compile }
          # Add Check to validate change was successful
        end
        context 'config_file' do
          before(:each) { params.merge!(config_file: '/foo/bar.conf') }
          it { is_expected.to compile }
          # Add Check to validate change was successful
        end
        context 'include_dir' do
          before(:each) { params.merge!(include_dir: '/foo/bar') }
          it { is_expected.to compile }
          # Add Check to validate change was successful
        end
        context 'logfile' do
          before(:each) { params.merge!(logfile: '/foo/bar') }
          it { is_expected.to compile }
          # Add Check to validate change was successful
        end
        context 'logfile_maxbytes' do
          before(:each) { params.merge!(logfile_maxbytes: '100MB') }
          it { is_expected.to compile }
          # Add Check to validate change was successful
        end
        context 'logfile_backups' do
          before(:each) { params.merge!(logfile_backups: 42) }
          it { is_expected.to compile }
          # Add Check to validate change was successful
        end
        context 'logfile_loglevel' do
          before(:each) { params.merge!(logfile_loglevel: 'error') }
          it { is_expected.to compile }
          # Add Check to validate change was successful
        end
        context 'pidfile' do
          before(:each) { params.merge!(pidfile: '/foo/bar.pid') }
          it { is_expected.to compile }
          # Add Check to validate change was successful
        end
        context 'umask' do
          before(:each) { params.merge!(umask: '022') }
          it { is_expected.to compile }
          # Add Check to validate change was successful
        end
        context 'nodaemon' do
          before(:each) { params.merge!(nodaemon: false) }
          it { is_expected.to compile }
          # Add Check to validate change was successful
        end
        context 'minfds' do
          before(:each) { params.merge!(minfds: 42) }
          it { is_expected.to compile }
          # Add Check to validate change was successful
        end
        context 'minprocs' do
          before(:each) { params.merge!(minprocs: 42) }
          it { is_expected.to compile }
          # Add Check to validate change was successful
        end
        context 'nocleanup' do
          before(:each) { params.merge!(nocleanup: false) }
          it { is_expected.to compile }
          # Add Check to validate change was successful
        end
        context 'childlogdir' do
          before(:each) { params.merge!(childlogdir: '/foo/bar') }
          it { is_expected.to compile }
          # Add Check to validate change was successful
        end
        context 'user' do
          before(:each) { params.merge!(user: 'foobar') }
          it { is_expected.to compile }
          # Add Check to validate change was successful
        end
        context 'directory' do
          before(:each) { params.merge!(directory: '/foo/bar') }
          it { is_expected.to compile }
          # Add Check to validate change was successful
        end
        context 'strip_ansi' do
          before(:each) { params.merge!(strip_ansi: true) }
          it { is_expected.to compile }
          # Add Check to validate change was successful
        end
        context 'environment' do
          before(:each) { params.merge!(environment: { 'foo' => 'bar' }) }
          it { is_expected.to compile }
          # Add Check to validate change was successful
        end
        context 'identifier' do
          before(:each) { params.merge!(identifier: 'foobar') }
          it { is_expected.to compile }
          # Add Check to validate change was successful
        end
        context 'serverurl' do
          before(:each) { params.merge!(serverurl: 'unix:///foobar') }
          it { is_expected.to compile }
          # Add Check to validate change was successful
        end
        context 'username' do
          before(:each) { params.merge!(username: 'foobar') }
          it { is_expected.to compile }
          # Add Check to validate change was successful
        end
        context 'password' do
          before(:each) { params.merge!(password: 'foobar') }
          it { is_expected.to compile }
          # Add Check to validate change was successful
        end
        context 'prompt' do
          before(:each) { params.merge!(prompt: 'foobar') }
          it { is_expected.to compile }
          # Add Check to validate change was successful
        end
        context 'history_file' do
          before(:each) { params.merge!(history_file: '/foo/bar') }
          it { is_expected.to compile }
          # Add Check to validate change was successful
        end
        context 'unix_http_server_enable' do
          before(:each) { params.merge!(unix_http_server_enable: false) }
          it { is_expected.to compile }
          # Add Check to validate change was successful
        end
        context 'unix_http_server_file' do
          before(:each) { params.merge!(unix_http_server_file: '/foo/bar') }
          it { is_expected.to compile }
          # Add Check to validate change was successful
        end
        context 'unix_http_server_chmod' do
          before(:each) { params.merge!(unix_http_server_chmod: '0420') }
          it { is_expected.to compile }
          # Add Check to validate change was successful
        end
        context 'unix_http_server_chown' do
          before(:each) { params.merge!(unix_http_server_chown: 'foobar') }
          it { is_expected.to compile }
          # Add Check to validate change was successful
        end
        context 'unix_http_server_chown user and group' do
          before(:each) { params.merge!(unix_http_server_chown: 'foo:bar') }
          it { is_expected.to compile }
          # Add Check to validate change was successful
        end
        context 'unix_http_server_username' do
          before(:each) { params.merge!(unix_http_server_username: 'foobar') }
          it { is_expected.to compile }
          # Add Check to validate change was successful
        end
        context 'unix_http_server_password' do
          before(:each) { params.merge!(unix_http_server_password: 'foobar') }
          it { is_expected.to compile }
          # Add Check to validate change was successful
        end
        context 'inet_http_enable' do
          before(:each) { params.merge!(inet_http_enable: true) }
          it { is_expected.to compile }
          # Add Check to validate change was successful
        end
        context 'inet_http_server_ip' do
          before(:each) { params.merge!(inet_http_server_ip: '192.0.2.42') }
          it { is_expected.to compile }
          # Add Check to validate change was successful
        end
        context 'inet_http_server_port' do
          before(:each) { params.merge!(inet_http_server_port: 42) }
          it { is_expected.to compile }
          # Add Check to validate change was successful
        end
        context 'inet_http_server_username' do
          before(:each) { params.merge!(inet_http_server_username: 'foobar') }
          it { is_expected.to compile }
          # Add Check to validate change was successful
        end
        context 'inet_http_server_password' do
          before(:each) { params.merge!(inet_http_server_password: 'foobar') }
          it { is_expected.to compile }
          # Add Check to validate change was successful
        end
        context 'programs' do
          before(:each) do
            params.merge!(
              programs: {
                'foobar' => {
                  'command' => '/foo/bar',
                },
              },
            )
          end
          it { is_expected.to compile }
          it do
            is_expected.to contain_file(
              '/etc/supervisor/conf.d/foobar.conf',
            ).with_ensure('file').with_content(
              %r{
              \[program:foobar\]\n
              command\s=\s/foo/bar
              }x,
            )
          end
        end
      end
      describe 'check bad type' do
        context 'packages' do
          before(:each) { params.merge!(packages: true) }
          it { is_expected.to raise_error(Puppet::Error) }
        end
        context 'service' do
          before(:each) { params.merge!(service: true) }
          it { is_expected.to raise_error(Puppet::Error) }
        end
        context 'config_dir' do
          before(:each) { params.merge!(config_dir: true) }
          it { is_expected.to raise_error(Puppet::Error) }
        end
        context 'config_file' do
          before(:each) { params.merge!(config_file: true) }
          it { is_expected.to raise_error(Puppet::Error) }
        end
        context 'include_dir' do
          before(:each) { params.merge!(include_dir: true) }
          it { is_expected.to raise_error(Puppet::Error) }
        end
        context 'logfile' do
          before(:each) { params.merge!(logfile: true) }
          it { is_expected.to raise_error(Puppet::Error) }
        end
        context 'logfile_maxbytes' do
          before(:each) { params.merge!(logfile_maxbytes: true) }
          it { is_expected.to raise_error(Puppet::Error) }
        end
        context 'logfile_backups' do
          before(:each) { params.merge!(logfile_backups: true) }
          it { is_expected.to raise_error(Puppet::Error) }
        end
        context 'logfile_loglevel' do
          before(:each) { params.merge!(logfile_loglevel: true) }
          it { is_expected.to raise_error(Puppet::Error) }
        end
        context 'pidfile' do
          before(:each) { params.merge!(pidfile: true) }
          it { is_expected.to raise_error(Puppet::Error) }
        end
        context 'umask' do
          before(:each) { params.merge!(umask: true) }
          it { is_expected.to raise_error(Puppet::Error) }
        end
        context 'nodaemon' do
          before(:each) { params.merge!(nodaemon: 'foobar') }
          it { is_expected.to raise_error(Puppet::Error) }
        end
        context 'minfds' do
          before(:each) { params.merge!(minfds: true) }
          it { is_expected.to raise_error(Puppet::Error) }
        end
        context 'minprocs' do
          before(:each) { params.merge!(minprocs: true) }
          it { is_expected.to raise_error(Puppet::Error) }
        end
        context 'nocleanup' do
          before(:each) { params.merge!(nocleanup: 'foobar') }
          it { is_expected.to raise_error(Puppet::Error) }
        end
        context 'childlogdir' do
          before(:each) { params.merge!(childlogdir: true) }
          it { is_expected.to raise_error(Puppet::Error) }
        end
        context 'user' do
          before(:each) { params.merge!(user: true) }
          it { is_expected.to raise_error(Puppet::Error) }
        end
        context 'directory' do
          before(:each) { params.merge!(directory: true) }
          it { is_expected.to raise_error(Puppet::Error) }
        end
        context 'strip_ansi' do
          before(:each) { params.merge!(strip_ansi: 'foobar') }
          it { is_expected.to raise_error(Puppet::Error) }
        end
        context 'environment' do
          before(:each) { params.merge!(environment: true) }
          it { is_expected.to raise_error(Puppet::Error) }
        end
        context 'identifier' do
          before(:each) { params.merge!(identifier: true) }
          it { is_expected.to raise_error(Puppet::Error) }
        end
        context 'serverurl' do
          before(:each) { params.merge!(serverurl: true) }
          it { is_expected.to raise_error(Puppet::Error) }
        end
        context 'username' do
          before(:each) { params.merge!(username: true) }
          it { is_expected.to raise_error(Puppet::Error) }
        end
        context 'password' do
          before(:each) { params.merge!(password: true) }
          it { is_expected.to raise_error(Puppet::Error) }
        end
        context 'prompt' do
          before(:each) { params.merge!(prompt: true) }
          it { is_expected.to raise_error(Puppet::Error) }
        end
        context 'history_file' do
          before(:each) { params.merge!(history_file: true) }
          it { is_expected.to raise_error(Puppet::Error) }
        end
        context 'unix_http_server_enable' do
          before(:each) { params.merge!(unix_http_server_enable: 'foobar') }
          it { is_expected.to raise_error(Puppet::Error) }
        end
        context 'unix_http_server_file' do
          before(:each) { params.merge!(unix_http_server_file: true) }
          it { is_expected.to raise_error(Puppet::Error) }
        end
        context 'unix_http_server_chmod' do
          before(:each) { params.merge!(unix_http_server_chmod: true) }
          it { is_expected.to raise_error(Puppet::Error) }
        end
        context 'unix_http_server_chown' do
          before(:each) { params.merge!(unix_http_server_chown: true) }
          it { is_expected.to raise_error(Puppet::Error) }
        end
        context 'unix_http_server_username' do
          before(:each) { params.merge!(unix_http_server_username: true) }
          it { is_expected.to raise_error(Puppet::Error) }
        end
        context 'unix_http_server_password' do
          before(:each) { params.merge!(unix_http_server_password: true) }
          it { is_expected.to raise_error(Puppet::Error) }
        end
        context 'inet_http_enable' do
          before(:each) { params.merge!(inet_http_enable: 'foobar') }
          it { is_expected.to raise_error(Puppet::Error) }
        end
        context 'inet_http_server_ip' do
          before(:each) { params.merge!(inet_http_server_ip: true) }
          it { is_expected.to raise_error(Puppet::Error) }
        end
        context 'inet_http_server_port' do
          before(:each) { params.merge!(inet_http_server_port: true) }
          it { is_expected.to raise_error(Puppet::Error) }
        end
        context 'inet_http_server_username' do
          before(:each) { params.merge!(inet_http_server_username: true) }
          it { is_expected.to raise_error(Puppet::Error) }
        end
        context 'inet_http_server_password' do
          before(:each) { params.merge!(inet_http_server_password: true) }
          it { is_expected.to raise_error(Puppet::Error) }
        end
        context 'programs' do
          before(:each) { params.merge!(programs: true) }
          it { is_expected.to raise_error(Puppet::Error) }
        end
      end
    end
  end
end
