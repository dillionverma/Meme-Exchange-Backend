require 'sidekiq'
require 'sidekiq/web'

Sidekiq.configure_server do |config|
  schedule_file = 'config/schedule.yml'

  if File.exists?(schedule_file) && Sidekiq.server?
    Sidekiq::Cron::Job.load_from_hash! YAML.load_file(schedule_file)
  end
end


Sidekiq::Web.use(Rack::Auth::Basic) do |user, password|
  [user, password] == ["admin", "memelordthegoose"]
end
