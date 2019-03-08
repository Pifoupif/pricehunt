
namespace :alert do

  task :daily_offers_update_service => :environment do
    daily_offers_update
  end

  task :randomize_prices => :environment do
    randomize_prices
  end

  task :quick_seed => :environment do
    8.times do
      daily_offers_update
    end
    randomize_prices
  end


  private

  def daily_offers_update
    alerts = Alert.all
    alerts.each do |alert|
      DailyOffersUpdateService.new(alert).call
    end
  end

  def randomize_prices
    Alert.all.each do |alert|
      alert.prices[0..-2].each do |p|
        old_price = p.price
        new_price = (1-(rand(-1..1) * rand/6))*old_price
        p.update price: new_price
      end
    end
  end
end
