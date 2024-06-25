# bin/temperature_spread.rb
# frozen_string_literal: true

class TemperatureSpread
  attr_reader :file_relative_path

  def initialize(file_relative_path)
    @file_relative_path = file_relative_path
  end

  def day_with_smallest_spread
    @data.min_by { |day| day.spread }
  end
end
