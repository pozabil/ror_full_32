require_relative './classes/station.rb'
require_relative './classes/route.rb'
require_relative './classes/cargo_train.rb'
require_relative './classes/passenger_train.rb'
require_relative './classes/cargo_railcar.rb'
require_relative './classes/passenger_railcar.rb'
require_relative './classes/interface.rb'

interface = Interface.new
interface.start
