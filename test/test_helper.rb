# frozen_string_literal: true

ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all
  include FactoryBot::Syntax::Methods

  # Add more helper methods to be used by all tests here...
  def signup(user, password: "password")
    params = { user: user.attributes.merge(password:, password_confirmation: password) }
    post users_path, params: params
  end

  def login(user, password: "password")
    post sessions_path, params: { email: user.email, password: }
  end
end
