# frozen_string_literal: true

class MatrixService < ApplicationService
  def initialize(matrix)
    @matrix = matrix
  end

  def process
    Rectangle.new(matrix:, area: max_rectangle_area).rectangle
  end

  private
    attr_reader :matrix

    def histograms
      Histogram::Base.new(matrix).heights
    end

    def max_rectangle_area
      histograms.map do |histogram|
        Histogram::Area.new(histogram).max
      end.max
    end
end
