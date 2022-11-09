# frozen_string_literal: true

module Histogram
  class Area
    def initialize(heights)
      @heights = heights
    end

    def max
      indexes = [-1]
      area = 0

      heights.each_with_index do |height, idx|
        while indexes.length != 1 && indexes.first != -1 && heights[indexes.first] >= height
          current_height = heights[indexes.first]
          indexes.shift
          width = idx - indexes.first - 1
          area = [area, current_height * width].max
        end
        indexes.unshift(idx)
      end

      while indexes.length != 1
        idx = indexes.shift
        width = heights.length - indexes.first - 1
        height = heights[idx]
        area = [area, width * height].max
      end

      area
    end

    private
      attr_reader :heights
  end
end
