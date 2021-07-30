require_relative './classes/station.rb'
require_relative './classes/route.rb'
require_relative './classes/cargo_train.rb'
require_relative './classes/passenger_train.rb'
require_relative './classes/cargo_railcar.rb'
require_relative './classes/passenger_railcar.rb'

stations = {}
routes = {}
trains = {}
#railcars = {}

loop do

  puts 'Введите номер команды:'
  puts '1. Управлять станциями'
  puts '2. Управлять маршрутами'
  puts '3. Управлять поездами'
  puts '0. Выход'
  basic_choice = gets.to_i

  case basic_choice

  when 1 #Управлять станциями

    loop do

      puts 'Выберите действие:'
      puts '1. Создать станцию'
      puts '2. Посмотреть список поездов на станции'
      puts '0. Назад'
      station_choice = gets.to_i

      case station_choice

      when 1 #Создать станцию

        loop do
          puts 'Введите название станции:'
          station_name = gets.chomp.to_sym

          if stations.has_key?(station_name)
            puts 'Такая станция уже существует!'
          else
            stations[station_name] = Station.new(station_name.to_s)
            puts "Станция #{station_name} успешно создана!"
            break
          end

        end
        break

      when 2 #Посмотреть список поездов на станции

        loop do
          puts 'Введите название станции:'
          station_name = gets.chomp.to_sym

          if stations.has_key?(station_name)
            puts "Список поездов на станции #{station_name}:"
            puts stations[station_name].trains
            break
          else
            puts 'Нет такой станции!'
          end

        end
        break

      when 0 #Назад
        break

      else
        puts 'Нет такого действия! Нажмите ввод...'
        gets
      end

    end

  when 2 #Управлять маршрутами

    loop do

      puts 'Выберите действие:'
      puts '1. Создать маршрут'
      puts '2. Добавить или убрать станцию на маршрут'
      puts '3. Посмотреть список станций на маршруте'
      puts '0. Назад'
      route_choice = gets.to_i

      case route_choice

      when 1 #Создать маршрут

        loop do

          puts 'Введите название маршрута:'
          route_name = gets.chomp.to_sym

          if routes.has_key?(route_name)
            puts 'Такой маршрут уже существует!'
          else

            first_station = ''.to_sym
            last_station = ''.to_sym

            loop do
              puts 'Введите название начальной станции:'
              first_station = gets.chomp.to_sym
              if stations.has_key?(first_station)
                break
              else
                puts 'Такой станции нет!'
              end
            end

            loop do
              puts 'Введите название конечной станции:'
              last_station = gets.chomp.to_sym
              if stations.has_key?(last_station)
                break
              else
                puts 'Такой станции нет!'
              end
            end

            routes[route_name] = Route.new(stations[first_station], stations[last_station])
            puts "Маршрут #{route_name} успешно создан!"
            break
          end

        end
        break

      when 2 #Добавить или убрать станцию на маршрут

        loop do

          puts 'Введите название маршрута:'
          route_name = gets.chomp.to_sym

          if routes.has_key?(route_name)

            loop do
              puts 'Введите название станции:'
              station_name = gets.chomp.to_sym

              if stations.has_key?(station_name)
                if (stations[station_name] == routes[route_name].stations[0]) ||
                  stations[station_name] == routes[route_name].stations[-1]
                  puts 'Нельзя убрать начальную или конечную станции'
                else
                  if routes[route_name].stations.include?(stations[station_name])
                    routes[route_name].remove_station(stations[station_name])
                    puts "Станция #{station_name} успешно убрана с маршрута #{route_name}!"
                  else
                    routes[route_name].add_station(stations[station_name])
                    puts "Станция #{station_name} успешно добавлена на маршрут #{route_name}!"                  
                  end
                end
                break

              else
                puts 'Нет такой станции!'
              end
            end
            break

          else
            puts 'Такого маршрута не существует!'
          end

        end
        break

      when 3 #Посмотреть список станций на маршруте

        loop do

          puts 'Введите название маршрута:'
          route_name = gets.chomp.to_sym

          if routes.has_key?(route_name)
            puts "Список станций на маршруте #{route_name}:"
            puts routes[route_name].stations
            break
          else
            puts 'Такого маршрута не существует!'
          end

        end
        break


      when 0 #Назад
        break

      else
        puts 'Нет такого действия! Нажмите ввод...'
        gets

      end

    end


  when 3 #Управлять поездами

    loop do

      puts 'Выберите действие:'
      puts '1. Создать поезд'
      puts '2. Назначить маршрут поезду'
      puts '3. Прицепить вагон к поезду'
      puts '4. Отцепить вагон от поезда'
      puts '5. Перемещать поезд вперед'
      puts '6. Перемещать поезд назад'
      puts '0. Назад'
      train_choice = gets.to_i

      case train_choice
      when 1 #Создать поезд

        loop do

          puts 'Введите номер поезда:'
          train_number = gets.chomp.to_sym

          if trains.has_key?(train_number)
            puts "Поезд номер #{train_number} уже существует!"
          else
            loop do            
              puts 'Введите тип поезда (cargo или passenger):'
              train_type = gets.chomp.downcase

              case train_type
              when 'cargo'
                trains[train_number] = CargoTrain.new(train_number.to_s)
                puts "Грузовой поезд номер #{train_number} успешно создан!"
                break
              when 'passenger'
                trains[train_number] = PassengerTrain.new(train_number.to_s)
                puts "Пассажирский поезд номер #{train_number} успешно создан!"                
                break
              else
                puts 'Неправильный тип поезда!'
              end

            end
            break

          end

        end
        break

      when 2 #Назначить маршрут поезду

        loop do

          puts 'Введите номер поезда'
          train_number = gets.chomp.to_sym

          if trains.has_key?(train_number)

            loop do
              puts 'Введите название маршрута'
              route_name = gets.chomp.to_sym

              if routes.has_key?(route_name)
                trains[train_number].get_route(routes[route_name])
                puts "Маршрут #{route_name} успешно назначен поезду номер #{train_number}!"
                break
              else
                puts 'Такого маршрута не существует!'
              end

            end
            break

          else
            puts 'Нет такого поезда!'
          end

        end
        break

      when 3 #Прицепить вагон к поезду

        loop do

          puts 'Введите номер поезда'
          train_number = gets.chomp.to_sym

          if trains.has_key?(train_number)
            if trains[train_number].type == 'cargo'
              trains[train_number].hook_railcar(CargoRailcar.new)
            elsif trains[train_number].type == 'passenger'
              trains[train_number].hook_railcar(PassengerRailcar.new)
            end
            puts "Вагон успешно прицеплен к поезду номер #{train_number}!"
            break
          else
            puts 'Нет такого поезда!'
          end

        end
        break

      when 4 #Отцепить вагон от поезда

        loop do

          puts 'Введите номер поезда'
          train_number = gets.chomp.to_sym

          if trains.has_key?(train_number)
            if trains[train_number].unhook_railcar
              puts "Вагон успешно отцеплен от поезда номер #{train_number}!"
              break
            else
              puts "У поезда номер #{train_number} больше нет вагонов!"
            end
          else
            puts 'Нет такого поезда!'
          end

        end
        break


      when 5 #Перемещать поезд вперед

        loop do

          puts 'Введите номер поезда'
          train_number = gets.chomp.to_sym   

          if trains.has_key?(train_number)
            if trains[train_number].forward
              puts "Поезд номер #{train_number} прибыл на станцию #{trains[train_number].current_station.name}!"
            else
              puts "Поезд номер #{train_number} и так стоит на конечной станции"
            end
            break
          else
            puts 'Нет такого поезда!'
          end

        end
        break

      when 6 #Перемещать поезд назад

        loop do

          puts 'Введите номер поезда'
          train_number = gets.chomp.to_sym   

          if trains.has_key?(train_number)
            if trains[train_number].backward
              puts "Поезд номер #{train_number} прибыл на станцию #{trains[train_number].current_station.name}!"
            else
              puts "Поезд номер #{train_number} и так стоит на начальной станции"
            end
            break
          else
            puts 'Нет такого поезда!'
          end

        end
        break

      when 0 #Назад
        break

      else
        puts 'Нет такого действия! Нажмите ввод...'
        gets

      end

    end

  when 0 #Выход

    puts 'Программа выключена'
    break

  else
    puts 'Нет такой команды! Нажмите ввод...'
    gets
  end

end

