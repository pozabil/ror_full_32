require_relative 'train.rb'

class CargoTrain < Train

  def type
    'cargo'
  end

  def hook_railcar(railcar)
    @railcars << railcar if railcar.type == 'cargo'
  end

end
