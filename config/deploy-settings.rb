# @Author: Robert D. Cotey II <coteyr@coteyr.net>
# @Date:   2014-10-17 00:02:43
# @Last Modified by:   Robert D. Cotey II <coteyr@coteyr.net>
# @Last Modified time: 2017-01-02 07:55:11


#setting file for deployment
  $application = "intelatek"

  set :use_sudo, false
  set :branch, "#{$branch}"
  set :repo_url,  "https://github.com/coteyr/gosellapp.git"




  set :public_path, "/home/#{$usr}/web/#{$application}-code/current/public"


# Default branch is :master
#  ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call


# Default deploy_to directory is /var/www/my_app
# set :deploy_to, '/var/www/my_app'

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# set :linked_files, %w{config/database.yml}
  set :linked_files, %w{config/database.yml}

# Default value for linked_dirs is []

set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system public/uploads}

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5
