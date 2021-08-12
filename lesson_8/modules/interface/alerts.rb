module Alerts
  private

  def print_quit_alert
    puts 'Программа выключена.'
  end

  def wrong_choice_alert
    puts 'Ошибка! Нет такой команды! Нажмите ввод...'
    gets
  end

  def station_already_exists_alert
    puts 'Такая станция уже существует!'
    puts
  end

  def station_does_not_exists_alert
    puts 'Нет такой станции!'
    puts
  end

  def route_already_exists_alert
    puts 'Такой маршрут уже существует!'
    puts
  end

  def route_does_not_exists_alert
    puts 'Такого маршрута не существует!'
    puts
  end

  def train_already_exists_alert
    puts 'Такой поезд уже существует!'
    puts
  end

  def train_does_not_exists_alert
    puts 'Такого поезда не существует!'
    puts
  end

  def wrong_train_type_alert
    puts 'Неправильный тип поезда!'
    puts
  end

  def wrong_railcar_number_alert
    puts 'Неверный номер вагона!'
    puts
  end

  def create_train_rescue_alert(exception)
    puts "Exception: #{exception.inspect}"
    puts exception.backtrace
    puts 'please try again...'
    puts
  end
end
