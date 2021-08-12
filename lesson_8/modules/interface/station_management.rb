module StationManagement
  private

  def train_at_station_list
    loop do
      station_name = get_station_name
      break if station_name == :break

      if @stations.key?(station_name)
        print_train_at_station_list(station_name)
        break
      else
        station_does_not_exists_alert
      end
    end; puts
  end

  def print_train_at_station_list(station_name)
    puts "Список поездов на станции #{station_name}:"
    @stations[station_name].trains_to_block do |train|
      puts "Номер поезда: #{train.number}, тип: #{train.type}," \
           " кол-во вагонов: #{train.railcars.size}."
    end
  end
end
