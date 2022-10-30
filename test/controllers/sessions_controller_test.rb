# frozen_string_literal: true

require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  attr_reader :user

  def setup
    @user = create :user
  end

  def test_should_get_new
    get new_session_path

    assert_equal "new", @controller.action_name
    assert_response :success
  end

  def test_should_redirect_new_if_logged_in
    login user
    get new_session_path

    assert_equal "new", @controller.action_name
    assert_redirected_to root_path
  end

  def test_should_redirect_create_on_successful_login
    login user

    assert_equal "create", @controller.action_name
    assert_equal user.id, session[:user_id]
    assert_equal "Successfully logged in!", flash[:success]
    assert_redirected_to root_path
  end

  def test_should_redirect_create_on_failed_login
    user.email = "example@example.com"
    login user

    assert_equal "create", @controller.action_name
    assert_equal "Incorrect credentials, try again.", flash[:error]
    assert_response :unauthorized
  end

  def test_should_redirect_destroy_when_not_logged_in
    delete session_path(user)

    assert_equal "destroy", @controller.action_name
    assert_redirected_to new_session_path
  end

  def test_should_redirect_destroy_on_logout
    login user
    delete session_path(user)

    assert_equal "destroy", @controller.action_name
    assert_nil session[:user_id]
    assert_equal "Successfully logged out!", flash[:notice]
    assert_redirected_to new_session_path
  end
end
