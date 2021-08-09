require_relative 'railcar.rb'

class PassengerRailcar < Railcar
  attr_reader :number_of_seats, :number_of_occupied_seats

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

  def type
    'passenger'
  end

  private

  attr_writer :number_of_occupied_seats

  def validate!
    super
    raise "Number of seats must be an Integer" unless number_of_seats.is_a? Integer
  end
end
