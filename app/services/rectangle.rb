# frozen_string_literal: true

class Rectangle
  def initialize(matrix:, area:)
    @matrix   = matrix
    @area     = area
    @max_rows = matrix.length
    @max_cols = matrix.first.length
  end

  def rectangle
    dimensions.each do |dimension|
      row, col = dimension

      i = 0
      while i < max_rows - 1 do
        break if i + row > max_rows

        sub_matrices = []
        matrix.slice(i, row).each do |r|
          j = 0
          while j < max_cols - 1 do
            break if j + col > max_cols

            sub_matrices[j] = [] if sub_matrices[j].nil?
            sub_matrices[j] << r.slice(j, col)
            j = j + 1
          end
        end

        sub_matrices.each do |sub_matrix|
          return sub_matrix if sub_matrix.flatten.all?(1)
        end
        i = i + 1
      end
    end
  end

  def factors
    (1...area).filter { |factor| area % factor == 0 }
  end

  def dimensions
    res = []
    factors.repeated_permutation(2) { |a| res << a if a.inject(:*) == area }
    res
  end

  private
    attr_reader :matrix, :area, :max_rows, :max_cols
end
