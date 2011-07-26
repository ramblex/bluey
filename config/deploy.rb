require 'bundler/capistrano'
set :application, "bluey_web"
set :repository,  "git://github.com/ramblex/bluey.git"
#set :user, "alexd"
set :user, "blueybot"
#set :ip, "178.79.132.38"
set :ip, "blueyfit.com"
ssh_options[:forward_agent] = true

default_run_options[:pty] = true

set :scm, :git
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

set :deploy_to, "/home/#{user}/#{application}"
#set :deploy_via, :remote_cache

set :default_environment, {
  'PATH' => '/home/blueybot/.rvm/gems/ruby-1.9.2-p180/bin:$PATH',
  'GEM_HOME' => '/home/blueybot/.rvm/gems/ruby-1.9.2-p180',
  'GEM_PATH' => '/home/blueybot/.rvm/gems/ruby-1.9.2-p180'
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
    run "ln -sfn /home/#{user}/#{application}/shared/database.yml #{release_path}/config/database.yml"
    run "ln -sfn /home/#{user}/#{application}/shared/bluey.mov #{release_path}/public/videos/bluey.mov"
  end

  after 'deploy:update_code', 'deploy:symlink_shared'
end
