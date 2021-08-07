require_relative '../modules/instance_counter.rb'
require_relative '../modules/validator.rb'

class Station
  include InstanceCounter
  include Validator

  NAME_FORMAT = /^[a-zA-Z ]+[a-zA-Z]$/

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

  private

  def validate!
    raise "Name has invalid format!" if name !~ NAME_FORMAT
    raise "Name is too long" if name.length >= 64
  end
end
