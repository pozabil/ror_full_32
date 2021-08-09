module TrainManagement
  private

  def assign_route_to_train
    loop do
      train_number = get_train_number

      break if train_number == :break

      if @trains.has_key?(train_number)
        assign_route(train_number)
        break
      else
        train_does_not_exists_alert
      end
    end
    puts
  end

  def assign_route(train_number)
    loop do
      route_name = get_route_name

      break if route_name == :break

      if @routes.has_key?(route_name)
        @trains[train_number].take_route(@routes[route_name])
        puts "Маршрут #{route_name} успешно назначен поезду номер #{train_number}!"
        break
      else
        route_does_not_exists_alert
      end
    end
  end

  def hook_railcar_to_train
    loop do
      train_number = get_train_number

      break if train_number == :break

      if @trains.has_key?(train_number)
        hook_railcar(train_number)
        break
      else
        train_does_not_exists_alert
      end
    end
    puts
  end

  def hook_railcar(train_number)
    if @trains[train_number].type == 'cargo'
      hook_cargo_railcar(train_number)
    elsif @trains[train_number].type == 'passenger'
      hook_passenger_railcar(train_number)
    end
    puts "Вагон успешно прицеплен к поезду номер #{train_number}!"
  end

  def hook_cargo_railcar(train_number)
    full_volume = get_full_volume
    trains[train_number].hook_railcar(CargoRailcar.new(full_volume))
  end

  def hook_passenger_railcar(train_number)
    number_of_seats = get_number_of_seats
    @trains[train_number].hook_railcar(PassengerRailcar.new(number_of_seats))
  end

  def unhook_railcar_to_train
    loop do
      train_number = get_train_number

      break if train_number == :break

      if @trains.has_key?(train_number)
        unhook_railcar(train_number)
        break
      else
        train_does_not_exists_alert
      end
    end
    puts
  end

  def unhook_railcar(train_number)
    if @trains[train_number].unhook_railcar
      puts "Вагон успешно отцеплен от поезда номер #{train_number}!"
    else
      puts "У поезда номер #{train_number} больше нет вагонов!"
    end
  end

  def train_railcar_list
    loop do
      train_number = get_train_number

      break if train_number == :break

      if @trains.has_key?(train_number)
        print_train_railcar_list(train_number)
        break
      else
        train_does_not_exists_alert
      end
    end
    puts
  end

  def print_train_railcar_list(train_number)
    puts "Список вагонов поезда номер #{train_number}:"
    i = 0
    @trains[train_number].railcars_to_block do |railcar|
      i += 1
      if railcar.type == 'cargo'
        puts "Порядковый номер вагона: #{i}, тип: #{railcar.type}," \
             " кол-во свободного объема: #{railcar.free_volume}, " \
             " кол-во заполненного объема: #{railcar.occupied_volume}."
      elsif railcar.type == 'passenger'
        puts "Порядковый номер вагона: #{i}, тип: #{railcar.type}," \
             " кол-во свободных мест: #{railcar.number_of_free_seats}, " \
             " кол-во занятых мест: #{railcar.number_of_occupied_seats}."
      end
    end
  end

  def move_train_forward
    loop do
      train_number = get_train_number

      break if train_number == :break

      if @trains.has_key?(train_number)
        train_movement_forward(train_number)
        break
      else
        train_does_not_exists_alert
      end
    end
    puts
  end

  def train_movement_forward(train_number)
    if @trains[train_number].forward
      puts "Поезд номер #{train_number} прибыл на " +
           "станцию #{@trains[train_number].current_station.name}!"
    else
      puts "Поезд номер #{train_number} и так стоит на конечной станции"
    end
  end

  def move_train_backward
    loop do
      train_number = get_train_number

      break if train_number == :break

      if @trains.has_key?(train_number)
        train_movement_backward(train_number)
        break
      else
        train_does_not_exists_alert
      end
    end
    puts
  end

  def train_movement_backward(train_number)
    if @trains[train_number].backward
      puts "Поезд номер #{train_number} прибыл на " +
           "станцию #{@trains[train_number].current_station.name}!"
    else
      puts "Поезд номер #{train_number} и так стоит на начальной станции"
    end
  end
end
