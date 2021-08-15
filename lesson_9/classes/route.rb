require_relative '../modules/instance_counter'
require_relative '../modules/validation'
require_relative '../modules/constants'

class Route
  include InstanceCounter
  include Validation
  include Constants

  attr_reader :name

  validate :name, :presence
  validate :name, :format, Constants::NAME_FORMAT

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

  private

  def validate!
    super
    raise 'name is too long' if name.length >= 64
  end
end
