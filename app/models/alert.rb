class Alert < ApplicationRecord
  #include ActiveModel::Validations
  #validates_with AlertPresenceValidator

  belongs_to :product
  belongs_to :user

  validates :target_price, presence: true
  validates :by_text_message, presence: true
  validates :by_email, presence: true
  #validates :by_email, inclusion: { in: [true],  unless: Proc.new { |a| a.by_text_message? }}
  #validates :by_text_message, inclusion: { in: [true], unless: Proc.new { |a| a.by_email? }}

  after_create :send_alert_email


  private

  def send_alert_email
    UserMailer.alert_set(self.user).deliver_now
  end
end
