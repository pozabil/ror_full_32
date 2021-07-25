numbers = [0, 1]

while numbers[-1] + numbers[-2] < 100
  numbers << numbers[-1] + numbers[-2]
end

puts numbers
