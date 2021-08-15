require_relative '../modules/company_info'
require_relative '../modules/instance_counter'
require_relative '../modules/validation'
require_relative '../modules/constants'

class Train
  include CompanyInfo
  include InstanceCounter
  include Validation
  include Constants

  @@trains = {}

  attr_reader :number, :speed, :railcars, :route, :type

  validate :type, :presence
  validate :type, :type, String
  validate :type, :format, Constants::TRAIN_TYPES
  validate :number, :presence
  validate :number, :type, String
  validate :number, :format, Constants::NUMBER_FORMAT

  def self.inherited(subclass)
    super
    subclass.validate :type, :presence
    subclass.validate :type, :type, String
    subclass.validate :type, :format, Constants::TRAIN_TYPES
    subclass.validate :number, :presence
    subclass.validate :number, :type, String
    subclass.validate :number, :format, Constants::NUMBER_FORMAT
  end

  def self.type
    @type = ''
  end

  def self.find(number)
    @@trains[number]
  end

  def initialize(number)
    @number = number
    @type = self.class.type
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
end
