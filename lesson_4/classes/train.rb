class Train
  
  attr_reader :number, :speed, :railcars

  def initialize(number)
    @number = number
    @railcars = []
    @speed = 0
  end

  def accelerate(value)
    @speed += value
  end

  def brake
    @speed = 0
  end

  def unhook_railcar
    @railcars.pop
  end

  def get_route(route)
    @route = route
    @position_on_route = 0
    current_station.train_arrival(self)
  end

  def forward
    if next_station
      current_station.train_departure(self)
      next_station.train_arrival(self)
      @position_on_route += 1
    end
  end

  def backward
    if previous_station
      current_station.train_departure(self)
      previous_station.train_arrival(self)
      @position_on_route -= 1
    end
  end

  def current_station
    @route.stations[@position_on_route]
  end

  def previous_station
    @route.stations[@position_on_route - 1] if @position_on_route > 0
  end

  def next_station
    @route.stations[@position_on_route + 1] if @position_on_route < (@route.stations.size - 1)
  end

end
