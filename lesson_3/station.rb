class Station

  attr_reader :trains

  def initialize(name)
    @name = name
    @trains = []
  end

  def train_arrival(train)
    @trains << train
  end

  def train_departure(train)
    @trains.delete(train)
  end

  def train_list(type) # passenger, freight
    trains.filter { |train| train.type = type }
  end

end
