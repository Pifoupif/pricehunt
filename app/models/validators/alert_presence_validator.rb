class AlertPresenceValidator < ActiveModel::Validator
  def validate(record)
    #if :by_email == false && :by_email :by_text_message
    # unless record.name.starts_with? 'X'
    #   record.errors[:name] << 'Need a name starting with X please!'
    # end
  end
end

