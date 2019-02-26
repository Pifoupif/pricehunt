class Alert < ApplicationRecord
  belongs_to :product
  belongs_to :user

  after_create :send_alert_email

  private

  def send_alert_email
    UserMailer.alert_set(self.user).deliver_now
  end
end
