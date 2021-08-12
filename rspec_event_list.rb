# frozen_string_literal: true

require 'rspec/autorun'
require_relative 'event_list'

describe EventList do
  let(:event) {Event.new('Battle of the Bands', 'Downtown', '2021-09-02', '16:00')}
  let(:event_list) { EventList.new }

  it 'adds an event' do
    event_list.add_event('2021-09-02', event)
    puts('Test Case 1')
    p(event_list)
    puts('Test Case Ended')
  end
  it 'updates an event' do
    puts('Test Case 2')
    event_list.add_event('2021-09-02', event)
    event_list.update_event('2021-09-02', 'Battle of the Bands')

    p(event_list)
    puts('Test Case Ended')
  end
  it 'deletes an event' do
    puts('Test Case 3')
    event_list.add_event('2021-09-02', event)
    event1 = Event.new('Battle of the Bands', 'Jersey', '2021-09-05', '12:00')
    event_list.add_event('2021-09-02', event1)

    event_list.delete_event('2021-09-02', 'Battle Of the Bands')
    p(event_list)
    puts('Test Case Ended')
  end
  it 'prints all events in a month' do
    puts('Test Case 4')
    event_list.add_event('2021-09-09', event)
    event1 = Event.new('Battle of the Bands', 'Jersey', '2021-09-05', '12:00')
    event_list.add_event('2021-09-06', event1)
    event2 = Event.new('Battle of the Bands', 'Jersey', '2021-09-05', '13:00')
    event_list.add_event('2021-09-05', event2)
    event_list.print_all_month_events(2021, 9)
    puts('Test Case Ended')
  end
  it 'it prints all events in a day' do
    puts('Test Case 4')
    event_list.add_event('2021-09-10', event)
    event1 = Event.new('Battle of the Bands', 'Jersey', '2021-09-05', '12:00')
    event_list.add_event('2021-09-10', event1)
    event2 = Event.new('Battle of the Bands', 'Jersey', '2021-09-05', '13:00')
    event_list.add_event('2021-09-10', event2)
    expect(event_list.print_all_day_events(2021, 9, 10)).to eq([event, event1, event2])
    puts('Test Case Ended')
  end
end