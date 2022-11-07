# frozen_string_literal: true

class MatricesController < ApplicationController
  skip_before_action :ensure_user_logged_in
  skip_before_action :verify_authenticity_token, only: [:create]
  before_action :ensure_valid_matrix, only: [:create]

  def new
    render
  end

  def create
    result = MatrixService.new(@matrix).process

    respond_to do |format|
      format.json { render json: { result: }, status: :ok }
      format.any { render turbo_stream: [ turbo_stream.prepend("result", result), turbo_stream.replace("result", partial: "result", locals: { result: } )] }
    end
  end

  private
    def ensure_valid_matrix
      @matrix = JSON.parse params[:matrix].tr("\n", "")

      raise JSON::ParserError unless @matrix.is_a?(Array) && @matrix.first.is_a?(Array)
    rescue JSON::ParserError
      flash.now[:error] = "Invalid input"
      render :new, status: :unprocessable_entity
    end
end
