require 'bundler/capistrano'
set :application, "bluey"
set :repository,  "git@github.com:ramblex/bluey.git"
set :user, "alexd"
set :ip, "178.79.132.38"
ssh_options[:forward_agent] = true

default_run_options[:pty] = true

set :scm, :git
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

set :deploy_to, "/home/#{user}/public_html/#{application}"
set :deploy_via, :remote_cache

set :default_environment, {
  'PATH' => '/var/lib/gems/1.8/bin:$PATH'
}

role :web, ip                          # Your HTTP server, Apache/etc
role :app, ip                          # This may be the same as your `Web` server
role :db,  ip, :primary => true # This is where Rails migrations will run

# If you are using Passenger mod_rails uncomment this:
# if you're still using the script/reapear helper you will need
# these http://github.com/rails/irs_process_scripts

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end

  task :symlink_shared do
    run "ln -sfn /home/#{user}/public_html/#{application}/shared/database.yml #{release_path}/config/database.yml"
  end

  after 'deploy:update_code', 'deploy:symlink_shared'
end
