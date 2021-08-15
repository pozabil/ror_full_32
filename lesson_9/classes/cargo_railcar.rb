require_relative 'railcar'

class CargoRailcar < Railcar
  attr_reader :full_volume, :occupied_volume

  validate :full_volume, :presence
  validate :full_volume, :type, Float

  def self.type
    @type = 'cargo'
  end

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

  private

  attr_writer :occupied_volume
end
