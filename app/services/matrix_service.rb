# frozen_string_literal: true

class MatrixService < ApplicationService
  def initialize(matrix)
    @matrix = matrix
    @row = @matrix.length
    @col = @matrix.first.length
    @sum_matrix = Array.new(row) { Array.new(col) { 0 } }
  end

  def process
    (0...row).each do |i|
      sum_matrix[i][0] = matrix[i][0]
    end

    (0...col).each do |i|
      sum_matrix[0][i] = matrix[0][i]
    end

    (0...row).each do |i|
      (0...col).each do |j|
        if matrix[i][j] == 1
          sum_matrix[i][j] = [sum_matrix[i][j - 1], sum_matrix[i - 1][j], sum_matrix[i - 1][j - 1]].min + 1
        else
          sum_matrix[i][j] = 0
        end
      end
    end

    sum_matrix_max = sum_matrix.first.first
    max_i = 0
    max_j = 0

    (0...row).each do |i|
      (0...col).each do |j|
        if sum_matrix_max < sum_matrix[i][j]
          sum_matrix_max = sum_matrix[i][j]
          max_i = i
          max_j = j
        end
      end
    end

    result = []
    (max_i).downto(max_i - sum_matrix_max + 1).each do |i|
      result_row = []
      (max_j).downto(max_j - sum_matrix_max + 1).each do |j|
        result_row << matrix[i][j]
      end
      result << result_row
    end

    result
  end

  private
    attr_reader :matrix, :row, :col, :sum_matrix
end
