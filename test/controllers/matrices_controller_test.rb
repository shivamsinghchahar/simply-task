# frozen_string_literal: true

require "test_helper"

class MatricesControllerTest < ActionDispatch::IntegrationTest
  def test_should_get_new
    get new_matrix_path

    assert_equal "new", @controller.action_name
    assert_select "h2", "Input a Matrix"
    assert_response :success
  end

  def test_create_returns_result_for_valid_input
    matrices.each_with_index do |matrix, index|
      post matrices_path, params: { matrix:, format: :json }

      assert_equal "create", @controller.action_name
      assert_response :success
      assert_equal results[index], response.parsed_body["result"]
    end
  end

  def test_create_returns_error_for_invalid_input
    post matrices_path, params: { matrix: "[]", format: :json }

    assert_equal "create", @controller.action_name
    assert_response :unprocessable_entity
    assert_equal "Invalid input", response.parsed_body["error"]
  end

  private
    def matrices
      [
        "[[0, 1, 0, 1, 1, 1], [1, 1, 1, 1, 1, 1], [1, 1, 1, 0, 0, 0], [1, 1, 1, 1, 1, 1]]",
        "[[0, 1, 0, 1, 0, 1], [1, 0, 1, 1, 1, 1], [1, 1, 1, 1, 0, 0], [1, 1, 1, 1, 1, 1]]",
        "[[0, 1, 0, 1, 0, 1], [1, 0, 1, 0, 1, 0], [1, 0, 1, 1, 0, 0], [1, 1, 1, 1, 1, 1]]",
        "[[1, 1, 0, 1, 0, 1], [1, 0, 1, 0, 1, 0], [1, 0, 1, 1, 0, 0], [1, 0, 1, 0, 1, 1]]",
        "[[0, 1, 0, 1, 0, 1], [1, 0, 1, 0, 1, 0], [1, 0, 1, 1, 0, 0], [1, 0, 1, 0, 1, 1]]",
        "[[1, 1, 1, 1, 1, 1], [1, 1, 1, 1, 1, 1], [1, 1, 1, 1, 1, 1], [1, 1, 1, 1, 1, 1]]",
        "[[1]]",
        "[[1, 0]]",
        "[[1], [1], [1], [0]]",
        "[[1, 1], [1, 1], [1, 1], [0, 0]]",
        "[[0, 1, 0, 1, 0, 1], [1, 0, 1, 0, 1, 0], [0, 1, 0, 1, 0, 1], [1, 0, 1, 0, 1, 0]]",
        "[[0]]"
      ]
    end

    def results
      [
        [[1, 1, 1], [1, 1, 1], [1, 1, 1]],
        [[1, 1, 1, 1], [1, 1, 1, 1]],
        [[1, 1, 1, 1, 1, 1]],
        [[1], [1], [1], [1]],
        [[1], [1], [1]],
        [[1, 1, 1, 1, 1, 1], [1, 1, 1, 1, 1, 1], [1, 1, 1, 1, 1, 1], [1, 1, 1, 1, 1, 1]],
        [[1]],
        [[1]],
        [[1], [1], [1]],
        [[1, 1], [1, 1], [1, 1]],
        [[1]],
        []
      ]
    end
end
