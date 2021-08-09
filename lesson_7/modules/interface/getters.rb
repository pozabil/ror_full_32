module Getters
  private

  def get_basic_choice
    puts 'Введите номер команды:'
    puts '1. Управлять станциями'
    puts '2. Управлять маршрутами'
    puts '3. Управлять поездами'
    puts '4. Управлять вагонами'
    puts '0. Выход'
    gets.to_i
  end

  def get_station_choice
      puts 'Выберите действие:'
      puts '1. Создать станцию'
      puts '2. Посмотреть список поездов на станции'
      puts '0. Назад'
      gets.to_i
  end

  def get_route_choice
    puts 'Выберите действие:'
    puts '1. Создать маршрут'
    puts '2. Добавить или убрать станцию на маршрут'
    puts '3. Посмотреть список станций на маршруте'
    puts '0. Назад'
    gets.to_i
  end

  def get_train_choice
    puts 'Выберите действие:'
    puts '1. Создать поезд'
    puts '2. Назначить маршрут поезду'
    puts '3. Прицепить вагон к поезду'
    puts '4. Отцепить вагон от поезда'
    puts '5. Вывести список вагонов у поезда'
    puts '6. Перемещать поезд вперед'
    puts '7. Перемещать поезд назад'
    puts '0. Назад'
    gets.to_i
  end

  def get_station_name(type = 'any')
    # Тип определяет начальная, конечная, или просто станция
    # Это нужно чтобы правильно выводить информацию по станции в консоль
    ru_type = if type == 'first'
                'начальной '
              elsif type == 'last'
                'конечной '
              else
                ''
              end
    puts "Введите название #{ru_type}станции (или break, чтобы выйти):"
    gets.chomp.to_sym
  end

  def get_station(type)
    station = :break
    loop do
      station = get_station_name(type)

      if (@stations.has_key?(station) || station == :break)
        break
      else
        station_does_not_exists_alert
      end
    end
    station
  end

  def get_route_name
    puts 'Введите название маршрута (или break, чтобы выйти):'
    gets.chomp.to_sym
  end

  def get_train_number
    puts 'Введите номер поезда (или break, чтобы выйти):'
    gets.chomp.to_sym
  end

  def get_train_type
    puts 'Введите тип поезда (cargo или passenger):'
    gets.chomp.downcase
  end

  def get_full_volume
    puts 'Введите полный доступный объем в вагоне:'
    gets.to_f
  end
  
  def get_number_of_seats
    puts 'Введите количество мест в вагоне:'
    gets.to_i
  end

  def get_railcar_number
    puts 'Введите порядковый номер вагона, который хотите занять' \
         ' (или break, чтобы выйти):'
    gets.to_i - 1
  end

  def get_volume
    puts 'Введите объем, который необходимо заполнить:'
    gets.to_f
  end
end
