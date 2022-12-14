# frozen_string_literal: true

class ApplicationController < ActionController::Base
  helper_method :logged_in?, :current_user
  before_action :ensure_user_logged_in
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  private
    def ensure_user_not_logged_in
      redirect_to root_path if logged_in?
    end

    def ensure_user_logged_in
      unless logged_in?
        flash[:danger] = "Please Log In"

        redirect_to new_session_path
      end
    end

    def logged_in?
      current_user.present?
    end

    def current_user
      if session[:user_id]
        @current_user ||= User.find(session[:user_id])
      end
    end

    def record_not_found(exception)
      flash[:error] = "No such data found in our record!"

      redirect_to root_path
    end
end
