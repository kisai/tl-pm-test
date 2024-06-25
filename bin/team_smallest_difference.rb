# bin/team_smallest_difference.rb
# frozen_string_literal: true

require 'logger'
require 'pry'

class TeamSmallestDifference
  attr_reader :file_relative_path
  attr_reader :logger
  attr_reader :file

  COLUMN_RANGES = {
    Team: 7..22,
    P: 23..28,
    W: 29..32,
    L: 33..36,
    D: 37..42,
    F: 43..45,
    A: 50..55,
    Pts: 56..58
  }

  def initialize(file_relative_path)
    @file_relative_path = file_relative_path
    @logger = Logger.new(STDOUT)

    unless File.exist?(file_relative_path)
      @logger.error('File does not exist')
      raise Errno::ENOENT, 'File does not exist'
    end

    unless File.file?(file_relative_path)
      @logger.error('Path is not a file')
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

  def team_with_smallest_difference
    smallest_difference = Float::INFINITY
    team_with_smallest_difference = ''

    file.each_line do |line|
      next unless valid_line?(line)

      team = column_at_name(line, :Team)
      goals_for = column_at_name(line, :F).to_i
      goals_against = column_at_name(line, :A).to_i
      difference = (goals_for - goals_against).abs

      if difference < smallest_difference
        smallest_difference = difference
        team_with_smallest_difference = team
      end
    end

    team_with_smallest_difference
  end
end

if __FILE__ == $PROGRAM_NAME
  team_smallest_difference = TeamSmallestDifference.new(ARGV[0].to_s)
  puts team_smallest_difference.team_with_smallest_difference
end
