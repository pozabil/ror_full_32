print 'Как тебя зовут? '
user_name = gets.chomp.capitalize

print 'Какой у тебя рост в см? '
user_height = gets.to_i

user_perfect_weight = ((user_height - 110) * 1.15).to_i #убираем дробную часть числа

if user_perfect_weight < 0
  puts "Твой вес уже оптимальный"
else
  puts "Товарищ #{user_name}, твой идеальный вес - это #{user_perfect_weight} кг"
end
