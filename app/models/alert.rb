class Alert < ApplicationRecord
  #include ActiveModel::Validations
  #validates_with AlertPresenceValidator

  belongs_to :product
  belongs_to :user
  has_many :lowest_prices, dependent: :destroy
  has_many :prices, through: :lowest_prices

  validates :target_price, presence: true
  before_validation :by_email_or_by_text_message

  #after_create :send_alert_email

  def lowest_price
    prices.last
  end

  def lowest_price_retailer
    # voir methode delegate
    prices.last.offer.retailer
  end

  private

  def by_email_or_by_text_message
    unless self.by_email || self.by_text_message
      errors.add(:by_email, "Please select a contact option")
      errors.add(:by_text_message, "Please select a contact option")
    end
  end

  def send_alert_email
    UserMailer.alert_set(self.user).deliver_now
  end
end
