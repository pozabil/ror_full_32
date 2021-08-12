module RailcarManagement
  private

  def railcar_management_action
    loop do
      train_number = get_train_number
      break if train_number == :break

      if @trains.key?(train_number)
        fill_volume_or_take_seat(train_number) if railcars?(train_number)
        break
      else
        train_does_not_exists_alert
      end
    end; puts
  end

  def railcars?(train_number)
    if @trains[train_number].railcars.size.zero?
      puts "У поезда номер #{train_number} нет вагонов!"
    else
      true
    end
  end

  def fill_volume_or_take_seat(train_number)
    loop do
      railcar_number = get_railcar_number
      break if railcar_number == -1

      if (railcar_number >= 0) && (railcar_number < @trains[train_number].railcars.size)
        fill_or_take(train_number, railcar_number)
        break
      else
        wrong_railcar_number_alert
      end
    end; puts
  end

  def fill_or_take(train_number, railcar_number)
    case @trains[train_number].type
    when 'cargo'
      fill_volume(train_number, railcar_number)
    when 'passenger'
      take_seat(train_number, railcar_number)
    end
  end

  def fill_volume(train_number, railcar_number)
    volume = get_volume
    if @trains[train_number].railcars[railcar_number].fill_volume(volume)
      puts 'Объем в вагоне успешно заполнен!'
    else
      puts 'Недостаточно свободного объема в вагоне!'
    end
  end

  def take_seat(train_number, railcar_number)
    if @trains[train_number].railcars[railcar_number].take_seat
      puts 'Место в вагоне успешно занято!'
    else
      puts 'Недостаточно свободных мест в вагоне!'
    end
  end
end
