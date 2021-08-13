# frozen_string_literal: true

# Event Class
class Event
  attr_accessor :id, :name, :venue, :date, :start_time

  @@id_increment = 0
  def initialize(name, venue, date, start_time)
    @@id_increment += 1
    @id = @@id_increment
    @name = name
    @venue = venue
    @date = date
    @start_time = start_time
  end

  def print_event
    p "Event number: #{id} + Event name: #{name} + Venue: #{venue} + start_time: #{start_time} + date of event: #{date}"
  end
end
