require_relative 'train'

class CargoTrain < Train
  def self.type
    @type = 'cargo'
  end
end
