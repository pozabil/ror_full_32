require_relative 'train_management/railcar_in_train_management'

module TrainManagement
  include RailcarInTrainManagement

  private

  def assign_route_to_train
    loop do
      train_number = get_train_number
      break if train_number == :break

      if @trains.key?(train_number)
        assign_route(train_number)
        break
      else
        train_does_not_exists_alert
      end
    end; puts
  end

  def assign_route(train_number)
    loop do
      route_name = get_route_name
      break if route_name == :break

      if @routes.key?(route_name)
        @trains[train_number].take_route(@routes[route_name])
        puts "Маршрут #{route_name} успешно назначен поезду номер #{train_number}!"
        break
      else
        route_does_not_exists_alert
      end
    end
  end

  def move_train_forward
    loop do
      train_number = get_train_number
      break if train_number == :break

      if @trains.key?(train_number)
        train_movement_forward(train_number) if on_route?(train_number)
        break
      else
        train_does_not_exists_alert
      end
    end; puts
  end

  def train_movement_forward(train_number)
    if @trains[train_number].forward
      puts "Поезд номер #{train_number} прибыл на " \
           "станцию #{@trains[train_number].current_station.name}!"
    else
      puts "Поезд номер #{train_number} и так стоит на конечной станции"
    end
  end

  def move_train_backward
    loop do
      train_number = get_train_number
      break if train_number == :break

      if @trains.key?(train_number)
        train_movement_backward(train_number) if on_route?(train_number)
        break
      else
        train_does_not_exists_alert
      end
    end; puts
  end

  def train_movement_backward(train_number)
    if @trains[train_number].backward
      puts "Поезд номер #{train_number} прибыл на " \
           "станцию #{@trains[train_number].current_station.name}!"
    else
      puts "Поезд номер #{train_number} и так стоит на начальной станции"
    end
  end

  def on_route?(train_number)
    if @trains[train_number].route.nil?
      puts "Поезд номер #{train_number} еще не на маршруте!"
    else
      true
    end
  end
end
