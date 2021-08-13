# frozen_string_literal: true

require 'date'
require_relative 'event'
require_relative 'event_list'

# class Calendar
class Calendar
  def time_val(time)
    return false if date.match(/\s/) || date.match("\n")
    return unless time =~ /\d{1,2}:\d{1,2}$/

    hour, seconds = time.split(':')
    return true if hour.to_i && seconds.to_i.positive? && hour.to_i && seconds.to_i < 61
  end

  def date_val(date)
    return false if date.match(/\s/) || date.match("\n")
    return unless date =~ /\d{4}-\d{1,2}-\d{1,2}$/

    year, month, day = date.split('-')
    return true if year.to_i && month.to_i && day.to_i.positive? && month.to_i < 13 && day.to_i < 32
  end

  def take_input(to_print)
    puts("Enter #{to_print}: ")
    value = gets.chomp
  end

  def date_search_eval(year, month, *day)
    if day
      return false if month.to_i < 1 || month.to_i > 12 || year.to_i < 1
    else
      return false if month.to_i < 1 || month.to_i > 12 || year.to_i < 1 || day.to_i < 1 || day.to_i > 31
    end
  end

  def calendar_run
    event_list = EventList.new
    loop do
      puts('Welcome to Ruby Calendar')
      puts('Press A- to ADD EVENT')
      puts('Press B- to UPDATE EVENT')
      puts('Press C- to DELETE EVENT')
      puts('Press D- to SHOW ALL EVENTS IN A MONTH')
      puts('Press E- to SHOW ALL EVENTS IN A DAY')
      puts('Press F- to SHOW MONTHLY VIEW')
      input = gets.chomp
      case input
      when 'A'
        name = take_input('event name')
        venue = take_input('event venue')
        date = take_input('event date')
        run_flag = date_val(date)
        if run_flag
          time = take_input('Enter time in format HH:MM')
          if time_val(time)
            event = Event.new(name, venue, date, time)
            event_list.add_event(date, event)
            puts('Event inserted successfully')
          else
            puts('Please enter time in the format HH:MM')
          end
        else
          puts('Incorrect Date input, YYYY-MM-DD in Numeric format')
        end
      when 'B'
        date = take_input('event date')
        run_flag = date_val(date)
        if run_flag
          name = take_input('event name')
          if event_list.update_event(date, name)
            puts('Successfully updated event')
          else
            puts("This Event doesn't exist")
          end
        else
          puts('Incorrect Date input, YYYY-MM-DD in Numeric format')
        end
      when 'C'
        date = take_input('event date')
        run_flag = date_val(date)
        if run_flag
          puts('Enter name: ')
          name = gets.chomp
          if event_list.delete_event(date, name)
            puts('Successfully deleted event')
          else
            puts("This Event doesn't exist")
          end
        else
          puts('Incorrect Date input, YYYY-MM-DD in Numeric format')
        end
      when 'D'
        year = take_input('year')
        month = take_input('month')
        if date_search_eval(year, month)
          event_list.print_all_month_events(year.to_i, month.to_i)
        else
          puts 'An error occured'
        end
      when 'E'
        year = take_input('year')
        month = take_input('month')
        day = take_input('day')
        if date_search_eval(year, month, day)
          event_list.print_all_day_events(year, month, day)
        else
          puts 'An error occured'
        end

      when 'F'
        year = take_input('year')
        month = take_input('month')
        month = month.to_i

        if month < 1 || month > 12 && year.positive?
          print 'Please enter a valid month'
        else
          event_list.print_month(year.to_i, month)
        end
      end
    end
  end
end

calendar = Calendar.new
calendar.calendar_run