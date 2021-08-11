# frozen_string_literal: true

# Controller Class
require 'date'
require_relative 'event'
require_relative 'event_list'

event_list = EventList.new

while true
  puts('Welcome to Ruby event_list')
  puts('Press A- to ADD EVENT')
  puts('Press B- to DELETE EVENT')
  puts('Press C- to UPDATE EVENT')
  puts('Press D- to SHOW ALL EVENTS IN A MONTH')
  puts('Press E- to SHOW ALL EVENTS IN A DAY')
  puts('Press F- to SHOW MONTHLY VIEW')
  input = gets.chomp
  case input
  when 'A'
    puts('Enter event name')
    name = gets.chomp
    puts('Enter event venue')
    venue = gets.chomp
    puts('Enter event date in format YYYY-MM-DD')
    date = gets.chomp
    if date =~ /\d{4}-\d{1,2}-\d{1,2}$/
      puts('Enter timestamp in format HH:MM')
      timestamp = gets.chomp
      event = Event.new(name, venue, date, timestamp)
      event_list.add_event(date, event)
      puts('Event inserted successfully')
    else
      puts('Incorrect Date input, YYYY-MM-DD in Numeric format')
    end
  when 'B'
    puts('Enter event date')
    date = gets.chomp
    if date =~ /\d{4}-\d{1,2}-\d{1,2}$/
      puts('Enter name')
      name = gets.chomp
      event_list.update_event(date, name)
      p event
    else
      puts('Incorrect Date input, YYYY-MM-DD in Numeric format')
    end
  when 'C'
    puts('Enter event date')
    date = gets.chomp
    if date =~ /\d{4}-\d{1,2}-\d{1,2}$/
      puts('Enter name')
      name = gets.chomp
      event_list.delete_event(date, name)
      p event
    else
      puts('Incorrect Date input, YYYY-MM-DD in Numeric format')
    end
  when 'D'
    puts('Enter year')
    year = gets.chomp
    puts('Enter month')
    month = gets.chomp
    event_list.print_all_month_events(year.to_i, month.to_i)
  when 'E'
    puts('Enter year')
    year = gets.chomp
    puts('Enter month')
    month = gets.chomp
    puts('Enter day')
    day = gets.chomp
    event_list.print_all_day_events(year.to_i, month.to_i, day.to_i)

  when 'F'
    puts('Enter year')
    year = gets.chomp
    puts('Enter month')
    month = gets.chomp
    month = month.to_i

    if month < 1 || month > 12
      print 'Please enter a valid month'
    else
      event_list.print_month(year.to_i, month)
    end
  end
end
