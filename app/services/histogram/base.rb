# frozen_string_literal: true

module Histogram
  class Base
    def initialize(matrix)
      @matrix = matrix
      @row    = matrix.length
      @col    = matrix[0].length
    end

    def heights
      histogram = Array.new(row) { Array.new(col, 0) }

      (0...row).each do |i|
        (0...col).each do |j|
          if i.zero?
            histogram[i][j] = matrix[i][j] - 0
          else
            histogram[i][j] = histogram[i - 1][j] + matrix[i][j] - 0 if matrix[i][j] == 1
          end
        end
      end

      histogram
    end

    private
      attr_reader :matrix, :row, :col
  end
end
