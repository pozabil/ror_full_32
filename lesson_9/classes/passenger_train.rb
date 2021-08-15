require_relative 'train'

class PassengerTrain < Train
  def self.type
    @type = 'passenger'
  end
end
