module StationManagement
  private

  def train_at_station_list
    loop do
      station_name = get_station_name

      break if station_name == :break

      if @stations.has_key?(station_name)
        print_train_at_station_list(station_name)
        break
      else
        station_does_not_exists_alert
      end
    end
    puts
  end

  def print_train_at_station_list(station_name)
    puts "Список поездов на станции #{station_name}:"
    puts @stations[station_name].trains
  end
end
