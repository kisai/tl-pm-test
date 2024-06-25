# spec/team_smallest_difference_spec.rb
# frozen_string_literal: true
require 'spec_helper'
require 'logger'

require_relative '../bin/team_smallest_difference'

RSpec.describe TeamSmallestDifference do
  let(:test_file) { 'spec/fixtures/soccer.dat' }
  let(:unexistant_path) { 'spec/fixtures/invalid.dat' }
  let(:directory_path) { 'spec/fixtures' }
  let(:team_smallest_difference) { TeamSmallestDifference.new(test_file) }
  let(:test_lines) { File.readlines(test_file) }

  before do
    @logger = Logger.new(STDOUT)
    allow(Logger).to receive(:new).and_return(@logger)
    allow(@logger).to receive(:error)
  end

  describe 'initialization' do
    it 'raises an error if the file does not exist' do
      expect { TeamSmallestDifference.new(unexistant_path) }.to raise_error(Errno::ENOENT)
      expect(@logger).to have_received(:error).with('File does not exist')
    end

    it 'raises an error if the path is not a file' do
      expect { TeamSmallestDifference.new(directory_path) }.to raise_error(Errno::EISDIR)
      expect(@logger).to have_received(:error).with('Path is not a file')
    end

    it 'creates an instance of TeamSmallestDifference' do
      expect(team_smallest_difference).to be_an_instance_of(TeamSmallestDifference)
    end
  end

  describe '#valid_line?' do
    it 'returns true for lines starting with numbers' do
      expect(team_smallest_difference.valid_line?(test_lines[3])).to be true
      expect(team_smallest_difference.valid_line?(test_lines[5])).to be true
    end

    it 'returns false for lines not starting with numbers' do
      invalid_lines = [0, 1, 2, 4, 6]
      invalid_lines.each do |index|
        expect(team_smallest_difference.valid_line?(test_lines[index])).to be false
      end
    end
  end

  describe '#team_with_smallest_difference' do
    it 'returns the team with the smallest goal difference' do
      expect(team_smallest_difference.team_with_smallest_difference).to eq('Team_2')
    end
  end
end
