goods = {}

loop do
  print "Введите название товара или \"Стоп/Stop\" чтобы закончить: "
  # почему-то неправильно работает с кириллицей, как-то связано с gets и backspace
  # если стирать буквы кириллицы то gets записывает некорректные результаты
  # или вообше выдает ошибку
  product_name = gets.chomp.capitalize
  break if product_name == "Стоп" || product_name == "Stop"
  print "Введите цену за еденицу товара: "
  product_price = gets.to_f
  print "Введите количество купленного товара: "
  product_quantity = gets.to_f
  goods[product_name] = {price: product_price, quantity: product_quantity}
end

puts goods
puts

total_cost = 0
puts "Товары в корзине: "
goods.each do |key, value|
  product_cost = value[:price] * value[:quantity]
  total_cost += product_cost
  puts "#{key} на сумму #{product_cost}"
end

puts "Итоговая сумма всех покупок в корзине: #{total_cost}"
