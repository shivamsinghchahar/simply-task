# frozen_string_literal: true

class SessionsController < ApplicationController
  before_action :ensure_user_not_logged_in
  skip_before_action :ensure_user_logged_in

  def new
    render
  end

  def create
    user = User.find_by(email: params[:email])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id.to_s
      flash[:success] = "Successfully logged in!"

      redirect_to root_path
    else
      flash[:error] = "Incorrect credentials, try again."

      render :new, status: :unauthorized
    end
  end
end
