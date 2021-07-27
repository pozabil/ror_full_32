class Route

  attr_reader :stations

  def initialize(first_station, last_station)
    @first_station = first_station
    @last_station = last_station
    @intermediate_stations = []
    update_station_list
  end

  def add_station(station)
    @intermediate_stations << station
    update_station_list
  end

  def remove_station(station)
    @intermediate_stations.delete(station)
    update_station_list
  end

  def station_list
    @stations.each { |station| puts station }
  end

  private

  def update_station_list
    @stations = @intermediate_stations.map(&:itself)
    @stations.unshift(@first_station).push(@last_station)
  end

end
