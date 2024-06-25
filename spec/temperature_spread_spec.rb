# spec/temperature_spread_spec.rb
# frozen_string_literal: true
require 'spec_helper'
require 'logger'

require_relative '../bin/temperature_spread'

RSpec.describe TemperatureSpread do
  let(:test_file) { 'spec/fixtures/weather.dat' }
  let(:unexistant_path) { 'spec/fixtures/invalid.dat' }
  let(:directory_path) { 'spec/fixtures' }
  let(:temperature_spread) { TemperatureSpread.new(test_file) }
  let(:test_lines) { File.readlines(test_file) }

  before do
    @logger = Logger.new(STDOUT)
    allow(Logger).to receive(:new).and_return(@logger)
    allow(@logger).to receive(:error)
  end

  describe "initialization" do
    it 'raises an error if the file does not exist' do
      expect { TemperatureSpread.new(unexistant_path) }.to raise_error(Errno::ENOENT)
      expect(@logger).to have_received(:error).with("File does not exist")
    end
    it 'raises an error if the path is not a file' do
      expect { TemperatureSpread.new(directory_path) }.to raise_error(Errno::EISDIR)
      expect(@logger).to have_received(:error).with("Path is not a file")
    end
    it 'creates an instance of TemperatureSpread' do
      expect(temperature_spread).to be_an_instance_of(TemperatureSpread)
    end
  end

  describe '#valid_line?' do
    it 'returns true for lines starting with numbers' do
      expect(temperature_spread.valid_line(test_lines[4])).to be true
      expect(temperature_spread.valid_line(test_lines[5])).to be true
    end

    it 'returns false for lines not starting with numbers' do
      invalid_lines = [0, 1, 2, 3, 6, 7]
      invalid_lines.each do |index|
        expect(temperature_spread.valid_line?(test_lines[index])).to be false
      end
    end
  end

  describe "#day_with_smallest_spread" do
    it 'returns the day with the smallest temperature spread' do
      expect(temperature_spread.day_with_smallest_spread).to eq(10)
    end
  end
end
