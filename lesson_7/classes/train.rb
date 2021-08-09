require_relative '../modules/company_info.rb'
require_relative '../modules/instance_counter.rb'
require_relative '../modules/validator.rb'

class Train
  include CompanyInfo
  include InstanceCounter
  include Validator

  NUMBER_FORMAT = /^[a-zA-Z0-9]{3}-?[a-zA-Z0-9]{2}$/
  TRAIN_TYPES = ['cargo', 'passenger']

  @@trains = {}

  def self.find(number)
    @@trains[number]
  end

  attr_reader :number, :speed, :railcars

  def initialize(number)
    @number = number
    validate!
    @railcars = []
    @speed = 0
    @@trains[number] = self
  end

  def valid?
    validate!
    true
  rescue
    false
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
    if next_station
      current_station.train_departure(self)
      next_station.train_arrival(self)
      @position_on_route += 1
    end
  end

  def backward
    if previous_station
      current_station.train_departure(self)
      previous_station.train_arrival(self)
      @position_on_route -= 1
    end
  end

  def current_station
    @route.stations[@position_on_route]
  end

  def previous_station
    @route.stations[@position_on_route - 1] if @position_on_route > 0
  end

  def next_station
    @route.stations[@position_on_route + 1] if @position_on_route < (@route.stations.size - 1)
  end

  def railcars_to_block(&block)
    railcars.each { |railcar| yield(railcar) }
  end

  private

  def validate!
    raise "Number has invalid format!" if number !~ NUMBER_FORMAT
    raise "Unknown train type" unless TRAIN_TYPES.include?(type)
  end

  # Метод был вынесен в приват, так как этот метод не должен вызываться извне.
  # Он нужен только для того, чтобы показать, что он будет присутствовать в наследниках
  # и для того чтобы метод hook_railcar не выкидывал ошибку при проверке
  # @railcars << railcar if railcar.type == type, если пользователь создаст
  # объект класса Train
  def type; end
end
