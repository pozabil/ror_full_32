require_relative '../modules/interface/getters'
require_relative '../modules/interface/alerts'
require_relative '../modules/interface/creators'
require_relative '../modules/interface/basic_choices'

class Interface
  include Getters
  include Alerts
  include Creators
  include BasicChoices

  def initialize
    @stations = {}
    @routes = {}
    @trains = {}
  end

  def start
    loop do
      basic_choice = get_basic_choice

      if basic_choice.zero?
        print_quit_alert
        break
      end

      actions(basic_choice)
    end
  end

  private

  attr_reader :stations, :routes, :trains

  def actions(basic_choice)
    case basic_choice
    when 1
      station_managment
    when 2
      route_managment
    when 3
      train_managment
    when 4
      railcar_management
    else
      wrong_choice_alert
    end
  end
end
