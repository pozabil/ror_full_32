require_relative 'railcar'

class CargoRailcar < Railcar
  attr_reader :full_volume, :occupied_volume

  def initialize(full_volume)
    @full_volume = full_volume
    super()
    @occupied_volume = 0.0
  end

  def fill_volume(volume)
    self.occupied_volume += volume if (occupied_volume + volume) <= full_volume
  end

  def free_volume
    full_volume - occupied_volume
  end

  def type
    'cargo'
  end

  private

  attr_writer :occupied_volume

  def validate!
    super
    raise 'Full volume must be an Float' unless full_volume.is_a? Float
  end
end
