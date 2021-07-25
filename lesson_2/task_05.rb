# метод определения високосного года
def leap_year?(year)
  if (((year % 4 == 0) && (year % 100 != 0)) || (year % 400 == 0))
    true
  else
    false
  end
end

puts "Введите число, месяц, год: "
day, month, year = gets.to_i, gets.to_i, gets.to_i

number_of_days = {
  1 => 31,
  2 => leap_year?(year) ? 29 : 28,
  3 => 31,
  4 => 30,
  5 => 31,
  6 => 30,
  7 => 31,
  8 => 31,
  9 => 30,
  10 => 31,
  11 => 30,
  12 => 31
}

if ((month <= 12) && (day <= number_of_days[month]))
  set_day_number = day
  (month - 1).times {|m| set_day_number += number_of_days[m+1]}
  puts set_day_number
else
  puts "Ошибка! Такая дата невозможна!"
end
