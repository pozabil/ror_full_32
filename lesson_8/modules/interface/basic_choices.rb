require_relative 'station_management'
require_relative 'route_management'
require_relative 'train_management'
require_relative 'railcar_management'

module BasicChoices
  include StationManagement
  include RouteManagement
  include TrainManagement
  include RailcarManagement

  private

  def station_managment
    loop do
      station_choice = get_station_choice

      case station_choice
      when 1
        create_station
        break
      when 2
        train_at_station_list
        break
      when 0
        puts
        break
      else
        wrong_choice_alert
      end
    end
  end

  def route_managment
    loop do
      route_choice = get_route_choice

      case route_choice
      when 1
        create_route
        break
      when 2
        add_remove_station_on_route
        break
      when 3
        station_on_route_list
        break
      when 0
        puts
        break
      else
        wrong_choice_alert
      end
    end
  end

  def train_managment
    loop do
      train_choice = get_train_choice

      case train_choice
      when 1
        create_train
        break
      when 2
        assign_route_to_train
        break
      when 3
        move_train_forward
        break
      when 4
        move_train_backward
        break
      when 5
        hook_railcar_to_train
        break
      when 6
        unhook_railcar_to_train
        break
      when 7
        train_railcar_list
        break
      when 0
        puts
        break
      else
        wrong_choice_alert
      end
    end
  end

  def railcar_management
    railcar_management_action
  end
end
