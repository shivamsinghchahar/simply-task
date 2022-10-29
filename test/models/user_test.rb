# frozen_string_literal: true

require "test_helper"

class UserTest < ActiveSupport::TestCase
  attr_reader :user

  def setup
    @user = build :user
  end

  def test_first_name_should_be_present
    user.first_name = nil

    assert_not user.valid?
    assert_equal "First name can't be blank", user.errors.full_messages.to_sentence
  end

  def test_last_name_should_be_present
    user.last_name = nil

    assert_not user.valid?
    assert_equal "Last name can't be blank", user.errors.full_messages.to_sentence
  end

  def test_email_should_be_present
    user.email = nil

    assert_not user.valid?
    assert_equal "Email can't be blank", user.errors.full_messages.to_sentence
  end

  def test_first_name_should_have_valid_length
    user.first_name = "a" * 51

    assert_not user.valid?
    assert_equal "First name is too long (maximum is 50 characters)", user.errors.full_messages.to_sentence
  end

  def test_last_name_should_have_valid_length
    user.last_name = "a" * 51

    assert_not user.valid?
    assert_equal "Last name is too long (maximum is 50 characters)", user.errors.full_messages.to_sentence
  end

  def test_email_should_have_valid_length
    user.email = "a" * 244 + "@example.com"

    assert_not user.valid?
    assert_equal "Email is too long (maximum is 255 characters)", user.errors.full_messages.to_sentence
  end

  def test_email_should_be_unique_irrespective_of_case
    user.save

    new_user = build :user
    new_user.email = user.email.upcase

    assert_not new_user.valid?
    assert_equal "Email has already been taken", new_user.errors.full_messages.to_sentence
  end

  def test_email_format_should_accept_valid_emails
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      user.email = valid_address

      assert user.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  def test_email_format_should_reject_invalid_emails
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example. foo@bar_baz.com foo@bar+baz.com foo@bar..com]

    invalid_addresses.each do |invalid_address|
      user.email = invalid_address

      assert_not user.valid?, "#{invalid_address.inspect} should be invalid"
      assert_equal "Email is invalid", user.errors.full_messages.to_sentence
    end
  end

  def test_password_should_be_present
    user.password = user.password_confirmation = " " * 6

    assert_not user.valid?
    assert_equal "Password can't be blank", user.errors.full_messages.to_sentence
  end

  def test_password_should_have_valid_length
    user.password = user.password_confirmation = "a" * 5

    assert_not user.valid?
    assert_equal "Password is too short (minimum is 6 characters)", user.errors.full_messages.to_sentence
  end

  def test_password_digest_should_be_present
    user.password_digest = ""

    assert_not user.valid?
    assert_equal "Password can't be blank", user.errors.full_messages.to_sentence
  end

  def test_name_should_return_full_name
    assert_equal user.name, user.first_name + " " + user.last_name
  end
end
