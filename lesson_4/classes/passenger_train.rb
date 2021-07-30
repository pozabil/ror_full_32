require_relative 'train.rb'

class PassengerTrain < Train

  def type
    'passenger'
  end

  def hook_railcar(railcar)
    @railcars << railcar if railcar.type == 'passenger'
  end

end
