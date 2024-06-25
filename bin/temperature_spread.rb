# bin/temperature_spread.rb
# frozen_string_literal: true
#
require 'logger'

class TemperatureSpread
  attr_reader :file_relative_path
  attr_reader :logger
  attr_reader :file

  def initialize(file_relative_path)
    @file_relative_path = file_relative_path
    @logger = Logger.new(STDOUT)

    unless File.exist?(file_relative_path)
      @logger.error("File does not exist")
      raise Errno::ENOENT, 'File does not exist'
    end

    unless File.file?(file_relative_path)
      @logger.error("Path is not a file")
      raise Errno::EISDIR, 'Path is not a file'
    end

    @file = File.new(file_relative_path)
  end

  def valid_line?(line)
    line.strip.start_with?(/\d/)
  end

  def day_with_smallest_spread
    @data.min_by { |day| day.spread }
  end
end
