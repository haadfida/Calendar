# frozen_string_literal: true

require 'rspec/autorun'
require_relative 'event'

describe Event do
  it 'prints an Event' do
    event = Event.new('Battle of the Bands', 'Downtown', '2021-09-02', '16:00')
    event.print_Event
  end
end
