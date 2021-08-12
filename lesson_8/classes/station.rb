require_relative '../modules/instance_counter'
require_relative '../modules/validator'
require_relative '../modules/constants'

class Station
  include InstanceCounter
  include Validator
  include Constants

  @@stations = []

  attr_reader :trains, :name

  def self.all
    @@stations
  end

  def initialize(name)
    @name = name
    validate!
    @trains = []
    @@stations << self
  end

  def train_arrival(train)
    @trains << train
  end

  def train_departure(train)
    @trains.delete(train)
  end

  def train_list(type)
    trains.filter { |train| train.type == type }
  end

  def to_s
    "station: #{name}"
  end

  def trains_to_block(&block)
    trains.each { |train| block.call(train) }
  end

  private

  def validate!
    raise 'Name has invalid format!' if name !~ Constants::NAME_FORMAT
    raise 'Name is too long' if name.length >= 64
  end
end
