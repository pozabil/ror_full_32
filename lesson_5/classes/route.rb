require_relative '../modules/instance_counter.rb'

class Route
  include InstanceCounter
  
  def initialize(first_station, last_station)
    @first_station = first_station
    @last_station = last_station
    @intermediate_stations = []
  end

  def add_station(station)
    @intermediate_stations << station
  end

  def remove_station(station)
    @intermediate_stations.delete(station)
  end

  def stations
    [@first_station, *@intermediate_stations, @last_station]
  end
end
