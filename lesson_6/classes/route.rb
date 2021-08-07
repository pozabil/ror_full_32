require_relative '../modules/instance_counter.rb'
require_relative '../modules/validator.rb'

class Route
  include InstanceCounter
  include Validator

  NAME_FORMAT = /^[a-zA-Z ]+[a-zA-Z]$/

  attr_reader :name
  
  def initialize(name, first_station, last_station)
    @name = name
    validate!
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

  def validate!
    raise "Name has invalid format!" if name !~ NAME_FORMAT
    raise "Name is too long" if name.length >= 64
  end
end
