class Train
  
  attr_reader :speed, :number_of_railcars, :type

  def initialize(number, type, number_of_railcars)
    @number = number
    @type = type # passenger, freight
    @number_of_railcars = number_of_railcars
    @speed = 0
  end

  def accelerate(value)
    @speed += value
  end

  def brake
    @speed = 0
  end

  def hook_railcar
    number_of_railcars += 1 if @speed == 0
  end

  def unhook_railcar
    number_of_railcars -= 1 if (@speed == 0) && (number_of_railcars > 1) 
  end

  def get_route(route)
    @route = route
    @position_on_route = 0
    current_station.train_arrival(self)
  end

  def forward
    if position_on_route < (@route.stations.size - 1)
      current_station.train_departure(self)
      next_station.train_arrival(self)
      @position_on_route += 1
    end
  end

  def backward
    if position_on_route > 1
      current_station.train_departure(self)
      previous_station.train_arrival(self)
      @position_on_route -= 1
    end
  end

  def current_station
    @route.stations[position_on_route]
  end

  def previous_station
    @route.stations[position_on_route - 1] if position_on_route > 1
  end

  def next_station
    @route.stations[position_on_route - 1] position_on_route < (@route.stations.size - 1)
  end

end
