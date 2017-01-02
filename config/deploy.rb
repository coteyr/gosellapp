# @Author: Robert D. Cotey II <coteyr@coteyr.net>
# @Date:   2014-10-20 17:44:24
# @Last Modified by:   Robert D. Cotey II <coteyr@coteyr.net>
# @Last Modified time: 2017-01-02 07:54:58
# config valid only for Capistrano 3.1
# lock '3.2.1'

require File.expand_path('../deploy-settings.rb', __FILE__)
require File.expand_path('../deploy-custom.rb', __FILE__)

set :bundle_binstubs, nil
set :assets_dependencies, %w(app/assets lib/assets vendor/assets Gemfile.lock config/routes.rb)
Rake::Task["deploy:assets:precompile"].clear_actions
class PrecompileRequired < StandardError; end

namespace :deploy do
  desc 'Restart application'
  task :restart do
    on roles (:web) do
      execute :touch, current_path.join('tmp/restart.txt')
    end
    on roles(:worker), in: :sequence, wait: 5 do

      # upstart should restart these
      invoke 'clockwork:stop'
      invoke 'clockwork:start'
      invoke 'delayed_job:restart'
    end
  end
  task :notify do
    on roles (:web) do
    # sha = capture("cd #{repo_path} && git rev-parse HEAD")
      if fetch(:rails_env).to_s == 'staging'
        # system "curl 'http://ready.coteyr.net/projects/2/contexts/4/publish?context=4&key=ee1b656b975b8c00844d2e7e2c7262e7&sha=#{sha}'"
      elsif fetch(:rails_env).to_s == 'production'
        # system "curl 'http://ready.coteyr.net/projects/2/contexts/5/publish?context=5&key=ee1b656b975b8c00844d2e7e2c7262e7&sha=#{sha}'"
      end
    end
  end

  after :publishing, :restart
  after :publishing, :notify


  #after :restart, :clear_cache do
  #  on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
  #  end
  #end

  namespace :assets do
    desc "Precompile assets"
    task :precompile do
      on roles(fetch(:assets_roles)) do
        within release_path do
          with rails_env: fetch(:rails_env) do
            begin
              # find the most recent release
              latest_release = capture(:ls, '-xr', releases_path).split[1]

              # precompile if this is the first deploy
              raise PrecompileRequired  unless latest_release

              latest_release_path = releases_path.join(latest_release)

              # precompile if the previous deploy failed to finish precompiling
              execute(:ls, latest_release_path.join('assets_manifest_backup')) rescue raise(PrecompileRequired)

              fetch(:assets_dependencies).each do |dep|
                # execute raises if there is a diff
                execute(:diff, '-Naur', release_path.join(dep), latest_release_path.join(dep)) rescue raise(PrecompileRequired)
              end

              info("Skipping asset precompile, no asset diff found")

              # copy over all of the assets from the last release
              execute(:cp, '-r', latest_release_path.join('public', fetch(:assets_prefix)), release_path.join('public', fetch(:assets_prefix)))
            rescue PrecompileRequired
              execute(:rake, "assets:precompile")
            end
          end
        end
      end
    end
  end
end

after 'deploy:publishing', 'deploy:restart'

namespace :deploy do
  task :restart do
    invoke 'delayed_job:restart'
  end
end


