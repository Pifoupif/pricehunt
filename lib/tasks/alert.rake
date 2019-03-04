
namespace :alert do

  task :daily_offers_update_service => :environment do
    alerts = Alert.all
    alerts.each do |alert|
      DailyOffersUpdateService.new(self).call(alert)
    end
  end
end
