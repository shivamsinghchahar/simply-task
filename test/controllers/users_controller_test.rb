# frozen_string_literal: true

require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  attr_reader :user

  def setup
    @user = build :user
  end

  def test_should_get_new
    get new_user_path

    assert_equal "new", @controller.action_name
    assert_response :success
  end

  def test_should_redirect_new_if_logged_in
    signup user
    get new_user_path

    assert_equal "new", @controller.action_name
    assert_redirected_to root_path
  end

  def test_should_redirect_create_on_successful_signup
    assert_difference "User.count" do
      signup user
    end

    assert_equal "create", @controller.action_name
    assert session[:user_id]
    assert_equal "Successfully signed up!", flash[:notice]
    assert_redirected_to root_path
  end

  def test_should_redirect_create_on_failed_signup
    user.email = ""
    assert_no_difference "User.count" do
      signup user
    end

    assert_equal "create", @controller.action_name
    assert_select "#errors li", text: "Email can't be blank"
    assert_response :unprocessable_entity
  end
end
