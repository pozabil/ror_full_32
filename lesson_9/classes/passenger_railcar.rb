require_relative 'railcar'

class PassengerRailcar < Railcar
  attr_reader :number_of_seats, :number_of_occupied_seats

  validate :number_of_seats, :presence
  validate :number_of_seats, :type, Integer

  def self.type
    @type = 'passenger'
  end

  def initialize(number_of_seats)
    @number_of_seats = number_of_seats
    super()
    @number_of_occupied_seats = 0
  end

  def take_seat
    self.number_of_occupied_seats += 1 if number_of_occupied_seats < number_of_seats
  end

  def number_of_free_seats
    number_of_seats - number_of_occupied_seats
  end

  private

  attr_writer :number_of_occupied_seats
end
