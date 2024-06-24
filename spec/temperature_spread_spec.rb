# spec/temperature_spread_spec.rb
# frozen_string_literal: true
require 'spec_helper'

require_relative '../bin/temperature_spread'

RSpec.describe TemperatureSpread do
  let(:test_file) { 'spec/fixtures/weather.dat' }

  before do
    @temperature_spread = TemperatureSpread.new(test_file)
  end

  it 'should return the day with the smallest temperature spread' do
    expect(@temperature_spread.day_with_smallest_spread).to eq(10)
  end
end
