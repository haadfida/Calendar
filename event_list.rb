# frozen_string_literal: true

require 'date'
require_relative 'Event'
# implements the class EventList
class EventList
  attr_accessor :event_list, :days

  def initialize
    @event_list = Hash.new { |hash, key| hash[key] = Hash.new { |h1, k1| h1[k1] = Hash.new { |h2, k2| h2[k2] = [] } } }
    @days = {
      'Sunday' => 0,
      'Monday' => 1,
      'Tuesday' => 2,
      'Wednesday' => 3,
      'Thursday' => 4,
      'Friday' => 5,
      'Saturday' => 6
    }
  end

  def add_event(date, event)
    d = Date._parse(date)
    @event_list.dig(d[:year], d[:mon], d[:mday]) << event
  end

  def fetch_info_to_update
    print 'Enter the event number of the event you want to update '
    id = gets.chomp
    print 'Enter the new name of the event '
    updated_name = gets.chomp
    print 'Enter the new venue of the event '
    updated_venue = gets.chomp
    print 'Enter the new date of the event '
    updated_date = gets.chomp
    [id, updated_name, updated_venue, updated_date]
  end

  def update_event(date, name)
    d = Date._parse(date)
    # wrapper method
    @event_list.dig(d[:year], d[:mon], d[:mday]).select { |event| event.name = name }.map(&:print_event)
    id, updated_name, updated_venue, updated_date = fetch_info_to_update
    updated_event = @event_list[d[:year]][d[:mon]][d[:mday]].find { |event| event.id = id }
    updated_event.name = updated_name
    updated_event.venue = updated_venue
    updated_event.name = updated_name
    updated_event.date = updated_date
    updated_event.print_event
  end

  def delete_event(date, name)
    date_parsed = Date._parse(date)
    @event_list.dig(date_parsed[:year], date_parsed[:mon], date_parsed[:mday]).select { |event| event.name = name }.map(&:print_event)
    print 'Enter the event number of the event you want to delete '
    id = gets.chomp
    @event_list.dig(date_parsed[:year], date_parsed[:mon], date_parsed[:mday]).reject! { |event| event.id == id.to_i }
  end

  def print_all_month_events(year, month)
    p "All events on Month #{month} are"
    # stops working on Rubocop suggestion
    @event_list.dig(year, month).each do |key, value|
      value.each do |event|
        event.print_event
      end
    end
  end

  def print_all_day_events(year, month, day)
    p "All events on Day #{day} are"
    @event_list.dig(year, month, day).each(&:print_event)
  end

  def print_month(year, month)
    date = Date.new(year, month, 1)
    day = date.strftime('%A')
    start = @days[day]
    days = Date.new(year, month, -1).day
    i = 0
    j = 1
    puts("Sun\tMon\tTue\tWed\tThu\tFri\tSat")
    35.times do
      if i < start
        print("\t")
      elsif j >= days + 1
        break
      else
        events = @event_list.dig(year.to_i, month.to_i, day).length
        print(j.to_s)
        print("(#{events})") if events.positive?
        print("\t")
        j += 1
      end
      i += 1
      puts('') if (i % 7).zero?
    end
    puts('')
  end
end
