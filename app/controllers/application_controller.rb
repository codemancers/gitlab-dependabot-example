# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include ApplicationHelper
  protect_from_forgery with: :exception

  def authenticate
    redirect_to :login unless user_signed_in?
  end
end
