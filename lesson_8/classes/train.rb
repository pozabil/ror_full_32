require_relative '../modules/company_info'
require_relative '../modules/instance_counter'
require_relative '../modules/validator'
require_relative '../modules/constants'

class Train
  include CompanyInfo
  include InstanceCounter
  include Validator
  include Constants

  @@trains = {}

  def self.find(number)
    @@trains[number]
  end

  attr_reader :number, :speed, :railcars, :route

  def initialize(number)
    @number = number
    validate!
    @railcars = []
    @speed = 0
    @@trains[number] = self
  end

  def accelerate(value)
    @speed += value
  end

  def brake
    @speed = 0
  end

  def hook_railcar(railcar)
    @railcars << railcar if railcar.type == type
  end

  def unhook_railcar
    @railcars.pop
  end

  def take_route(route)
    @route = route
    @position_on_route = 0
    current_station.train_arrival(self)
  end

  def forward
    return if route.nil?
    return unless next_station

    current_station.train_departure(self)
    next_station.train_arrival(self)
    @position_on_route += 1
  end

  def backward
    return if route.nil?
    return unless previous_station

    current_station.train_departure(self)
    previous_station.train_arrival(self)
    @position_on_route -= 1
  end

  def current_station
    @route.stations[@position_on_route]
  end

  def previous_station
    @route.stations[@position_on_route - 1] if @position_on_route.positive?
  end

  def next_station
    @route.stations[@position_on_route + 1] if @position_on_route < (@route.stations.size - 1)
  end

  def railcars_to_block(&block)
    railcars.each { |railcar| block.call(railcar) }
  end

  private

  def validate!
    raise 'Number has invalid format!' if number !~ Constants::NUMBER_FORMAT
    raise 'Unknown train type' unless Constants::TRAIN_TYPES.include?(type)
  end

  def type; end
end
