# required classes
require 'date'
require_relative 'Event'
# implements the class EventList
# EventList new class
# Class method
class EventList
  attr_accessor :config, :days

  def initialize
    @config = Hash.new { |hash, key| hash[key] = Hash.new { |h1, k1| h1[k1] = Hash.new { |h2, k2| h2[k2] = [] } } }
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
    @config.dig(d[:year], d[:mon], d[:mday]) << event
  end

  def fetch_info_to_update
    print 'Enter the ID of the event you want to update '
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
    #wrapper method
    @config.dig(d[:year], d[:mon], d[:mday]).select{ |event| event.name = name }.map(&:print_Event)
    id, updated_name, updated_venue, updated_date = fetch_info_to_update
    updated_event = @config[d[:year]][d[:mon]][d[:mday]].find{|event| event.id=id}
    updated_event.name = updated_name
    updated_event.venue = updated_venue
    updated_event.name = updated_name
    updated_event.date = updated_date
    updated_event.print_Event  
  end

  def delete_event(date, name)
    date_parsed = Date._parse(date) 
    @config.dig(date_parsed[:year], date_parsed[:mon], date_parsed[:mday]).select { |event| event.name = name }.map(&:print_Event)
    print 'Enter the ID of the event you want to delete '
    id = gets.chomp
    @config.dig(date_parsed[:year], date_parsed[:mon], date_parsed[:mday]).reject! { |event| event.id == id.to_i }
  end

  def print_all_month_events(year, month)
    p "All events on Month #{month} are"
    @config.dig(year, month).each do |key, value|
      value.each do |event|
        event.print_Event
      end
    end
  end

  def print_all_day_events(year, month, day)
    p "All events on Day #{day} are"
    @config.dig(year, month, day).each(&:print_Event)
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
        events = @config.dig(year.to_i, month.to_i, day).length
        print(j.to_s)
        if events > 0
          print("(#{events})")
        end
        print("\t")
        j += 1
      end
      i += 1
      if i % 7 == 0
        puts('')
      end
    end
    puts('')
  end
end
