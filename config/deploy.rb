#Capistrano 2 deployment script

set :application,     "obd_reports"                  
set :domain,          "pacdcdtaprdrpt1.cable.comcast.com"
set :user,            "csamue4916c" unless exists?(:user)

set :repository,      "http://pacdcntdp01.cable.comcast.com:8080/svn/repos/IVR/DAS/obd_reports/trunk"
set :scm_username,    "!dasadmin"                        
set :scm_password,    "Rep051tory"                             

set :use_sudo,        false                                      
set :deploy_to,       "/opt/home/#{user}/#{application}"    
                   
# copy over right now until we get svn client installed on the server
set :deploy_via,      :copy
# don't cache until we get issue worked out with deleted files from svn
set :copy_cache,      false

role :app, domain

# Cap won't work on windows without the above line, see
# http://groups.google.com/group/capistrano/browse_thread/thread/13b029f75b61c09d
default_run_options[:pty] = true

desc "Explains usage"
task :help do
  puts "To deploy, run 'cap deploy'"
  puts "If deploying for the the first time, you must run 'cap deploy:setup' first"
  puts "To update the cron entry, run 'cap deploy:update_cron"
end

namespace :deploy do
  desc "Update the crontab file"
   task :update_crontab, :roles => :app do
     run "cd #{release_path} && /opt/home/#{user}/.gem/ruby/1.8/bin/whenever --update-crontab #{application}"
  end
  # Override tasks not needed for deployment of static files
  [:finalize_update, :restart].each do |no_task|
     task no_task do 
       # do nothing
     end
   end 
end

after "deploy:symlink", "deploy:update_crontab"
