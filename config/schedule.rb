set :application, "obd_reports"
set :user, "csamue4916c"
set :obd_env, "production"
set :gem_bin_path, "/opt/home/#{user}/.gem/ruby/1.8/bin"  #Need because cron cannot see the path env

set :cron_log, "/opt/home/#{user}/#{application}/shared/log/cron.log"
 
every 1.day, :at => '2:00 am' do
    command "cd /opt/home/#{user}/#{application}/current/ && DAS_ENV=#{obd_env} #{gem_bin_path}/rake create_reports"
end
