class ApplicationController < ActionController::Base
  protect_from_forgery
  before_action :count_alert_reach

  protected

  def after_sign_in_path_for(resource)
    sign_in_url = new_user_session_url
    if request.referer == sign_in_url
      super
    else
      stored_location_for(resource) || request.referer || root_path
    end
  end

  def count_alert_reach
    @nb_of_target = Alert.of(current_user).reach.count if user_signed_in?
  end
end
