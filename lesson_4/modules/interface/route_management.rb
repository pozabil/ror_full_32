module RouteManagement
  private

  def add_remove_station_on_route
    loop do
      route_name = get_route_name

      break if route_name == :break

      if @routes.has_key?(route_name)
        add_remove_station(route_name)
        break
      else
        route_does_not_exists_alert
      end
    end
    puts
  end

  def add_remove_station(route_name)
    loop do
      station_name = get_station_name

      break if station_name == :break

      if @stations.has_key?(station_name)
        adding_removing_station(station_name, route_name)
        break
      else
        station_does_not_exists_alert
      end
    end
  end

  def adding_removing_station(station_name, route_name)
    if @routes[route_name].stations.include?(@stations[station_name])
      remove_station_from_route(station_name, route_name)
    else
      add_station_to_route(station_name, route_name)
    end
  end

  def remove_station_from_route(station_name, route_name)
    if (@stations[station_name] == @routes[route_name].stations[0]) ||
      (@stations[station_name] == @routes[route_name].stations[-1])
      puts 'Нельзя убрать начальную или конечную станции'
    else
      @routes[route_name].remove_station(@stations[station_name])
      puts "Станция #{station_name} успешно убрана с маршрута #{route_name}!"
    end
  end

  def add_station_to_route(station_name, route_name)
    @routes[route_name].add_station(@stations[station_name])
    puts "Станция #{station_name} успешно добавлена на маршрут #{route_name}!"
  end

  def station_on_route_list
    loop do
      route_name = get_route_name

      break if route_name == :break

      if @routes.has_key?(route_name)
        print_station_on_route_list(route_name)
        break
      else
        route_does_not_exists_alert
      end
    end
    puts
  end

  def print_station_on_route_list(route_name)
    puts "Список станций на маршруте #{route_name}:"
    puts @routes[route_name].stations
  end
end