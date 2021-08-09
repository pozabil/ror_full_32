require_relative '../modules/interface/alerts.rb'
require_relative '../modules/interface/getters.rb'
require_relative '../modules/interface/creators.rb'
require_relative '../modules/interface/station_management.rb'
require_relative '../modules/interface/route_management.rb'
require_relative '../modules/interface/train_management.rb'
require_relative '../modules/interface/railcar_management.rb'

class Interface
  include Alerts
  include Getters
  include Creators
  include StationManagement
  include RouteManagement
  include TrainManagement
  include RailcarManagement

  def initialize 
    @stations = {}
    @routes = {}
    @trains = {}
  end

  def start
    loop do
      basic_choice = get_basic_choice

      case basic_choice
      when 1 # Управлять станциями
        station_managment
      when 2 # Управлять маршрутами
        route_managment
      when 3 # Управлять поездами
        train_managment
      when 4 # Управлять вагонами
        railcar_management
      when 0 # Выход
        print_quit_alert
        break
      else
        wrong_choice_alert
      end
    end
  end

  private

  attr_reader :stations, :routes, :trains

  def station_managment
    loop do
      station_choice = get_station_choice

      case station_choice
      when 1 # Создать станцию
        create_station
        break
      when 2 # Посмотреть список поездов на станции
        train_at_station_list
        break
      when 0 # Назад
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
      when 1 # Создать маршрут
        create_route
        break
      when 2 # Добавить или убрать станцию на маршрут
        add_remove_station_on_route
        break
      when 3 # Посмотреть список станций на маршруте
        station_on_route_list
        break
      when 0 # Назад
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
      when 1 # Создать поезд
        create_train
        break
      when 2 # Назначить маршрут поезду
        assign_route_to_train
        break
      when 3 # Прицепить вагон к поезду
        hook_railcar_to_train
        break
      when 4 # Отцепить вагон от поезда
        unhook_railcar_to_train
        break
      when 5 # Вывести список вагонов поезда
        train_railcar_list
        break
      when 6 # Перемещать поезд вперед
        move_train_forward
        break
      when 7 # Перемещать поезд назад
        move_train_backward
        break
      when 0 # Назад
        puts
        break
      else
        wrong_choice_alert
      end
    end
  end
end
