# bin/temperature_spread.rb
# frozen_string_literal: true
#
require 'logger'
require 'pry'

class TemperatureSpread
  attr_reader :file_relative_path
  attr_reader :logger
  attr_reader :file

  COLUMN_RANGES = {
    Dy: 2..3,
    MnT: 11..13,
    MxT: 5..7,
    AvT: 17..19,
    HDDay: 23..27,
    AvDP: 30..33,
    "1HrP": 35..38,
    TPcpn: 40..44,
    WxType: 46..51,
    PDir: 53..56,
    AvSp: 58..61,
    Dir: 63..65,
    MxS: 67..69,
    SkyC: 71..74,
    MxR: 76..78,
    MnR: 80..82,
    AvSLP: 83..88
  }

  def initialize(file_rel_path)
    @file_relative_path = file_rel_path
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

  def column_at_name(line, name)
    line[COLUMN_RANGES[name]].strip
  end

  def day_with_smallest_spread
    smallest_spread = Float::INFINITY
    smallest_spread_day = 1

    file.each_line do |line|
      next unless valid_line?(line)

      day = column_at_name(line, :Dy).to_i
      max_temp = column_at_name(line, :MxT).to_f
      min_temp = column_at_name(line, :MnT).to_f
      difference = (max_temp - min_temp).abs

      if difference < smallest_spread
        smallest_spread = difference
        smallest_spread_day = day
      end
    end

    smallest_spread_day
  end
end

if __FILE__ == $PROGRAM_NAME
  temperature_spread = TemperatureSpread.new(ARGV[0].to_s)
  puts temperature_spread.day_with_smallest_spread
end
