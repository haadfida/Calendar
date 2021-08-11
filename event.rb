class Event
  attr_accessor :id, :name, :venue, :date , :start_Time

  @@id_Increment = 0
  def initialize(name, venue, date, start_Time)
    @@id_Increment += 1
    @id = @@id_Increment
    @name = name
    @venue = venue
    @date = date
    @start_Time=start_Time
    #time
  end   
  def print_Event()
    p 'ID: ' +@id.to_s +
    ' Event name: ' +@name.to_s +
    ' Venue: ' +@venue.to_s +
    ' start_Time: ' + @start_Time +
    ' Date of event: ' +@date.to_s
  end

end
