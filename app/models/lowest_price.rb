class LowestPrice < ApplicationRecord
  belongs_to :price
  belongs_to :alert
  after_save :check_alert_reach_status

  private

  def check_alert_reach_status
    actual_price = price.price
    target_price = alert.target_price

    alert.update alert_reach: (actual_price <= target_price)
  end
end
