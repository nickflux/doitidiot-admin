desc "This task is called by the Heroku cron add-on"
task :cron => :environment do
  
  Rake::Task["doitidiot:get_angry"].invoke
  Rake::Task["doitidiot:daily_emails"].invoke
  
end
