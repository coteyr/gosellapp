# @Author: Robert D. Cotey II <coteyr@coteyr.net>
# @Date:   2014-10-17 00:02:43
# @Last Modified by:   Robert D. Cotey II <coteyr@coteyr.net>
# @Last Modified time: 2016-12-27 15:12:56
$usr = "intelatek"
$password = ""
$domain = ""
$branch = "production"


role :worker, ["#{$usr}@#{$domain}"]
role :web, ["#{$usr}@#{$domain}"]
role :db,  ["#{$usr}@#{$domain}"]
set :delayed_job_roles, [:web]

# server "#{$domain}", user: "#{$usr}", roles: %w{web app db}
set :deploy_to, "/home/#{$usr}/web/#{$application}-code"
set :branch, "#{$branch}"
set :tmp_dir, "/tmp/#{$usr}/#{$branch}"
