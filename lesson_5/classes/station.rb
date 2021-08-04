require_relative '../modules/instance_counter.rb'

class Station
  include InstanceCounter

  @@stations = []

  attr_reader :trains, :name

  def self.all
    @@stations
  end

  def initialize(name)
    @name = name
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
end
