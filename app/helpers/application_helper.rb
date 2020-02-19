# frozen_string_literal: true

module ApplicationHelper
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def user_signed_in?
    !current_user.nil?
  end

  def paginate(current_page, direction)
    current_page + direction
  end
end
