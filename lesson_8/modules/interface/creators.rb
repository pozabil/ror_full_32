module Creators
  private

  def create_station
    loop do
      station_name = get_station_name
      break if station_name == :break

      if @stations.key?(station_name)
        station_already_exists_alert
      else
        station_creating(station_name)
        break
      end
    end; puts
  end

  def station_creating(station_name)
    @stations[station_name] = Station.new(station_name.to_s)
    puts "Станция #{station_name} успешно создана!"
  end

  def create_route
    loop do
      route_name = get_route_name
      break if route_name == :break

      if @routes.key?(route_name)
        route_already_exists_alert
      else
        route_creating(route_name)
        break
      end
    end; puts
  end

  def route_creating(route_name)
    first_station = get_station('first')
    return unless first_station != :break

    last_station = get_station('last')
    return unless last_station != :break

    @routes[route_name] = Route.new(route_name, @stations[first_station], @stations[last_station])
    puts "Маршрут #{route_name} успешно создан!"
  end

  def create_train
    loop do
      train_number = get_train_number
      break if train_number == :break

      if @trains.key?(train_number)
        train_already_exists_alert
      else
        train_creating(train_number)
        break
      end
    rescue RuntimeError => e
      create_train_rescue_alert(e)
    end; puts
  end

  def train_creating(train_number)
    loop do
      train_type = get_train_type

      case train_type
      when 'cargo'
        create_cargo_train(train_number)
        break
      when 'passenger'
        create_passenger_train(train_number)
        break
      else
        wrong_train_type_alert
      end
    end
  end

  def create_cargo_train(train_number)
    @trains[train_number] = CargoTrain.new(train_number.to_s)
    puts "Грузовой поезд номер #{train_number} успешно создан!"
  end

  def create_passenger_train(train_number)
    @trains[train_number] = PassengerTrain.new(train_number.to_s)
    puts "Пассажирский поезд номер #{train_number} успешно создан!"
  end
end
