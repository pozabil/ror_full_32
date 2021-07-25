numbers = []

(10..100).each {|n| numbers << n if n % 5 == 0}

puts numbers
