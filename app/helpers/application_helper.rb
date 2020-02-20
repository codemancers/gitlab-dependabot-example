# frozen_string_literal: true

module ApplicationHelper
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def user_signed_in?
    !current_user.nil?
  end

  def paginate_repos_from_gitlab_response_headers(headers)
    {
      next: headers[:x_next_page],
      prev: headers[:x_prev_page],
      total_pages: headers[:x_total_pages],
      total: headers[:x_total],
      per_page: headers[:x_per_page]
    }
  end
end
