vowels_hash = {}

vowels = ['a', 'e', 'i', 'o', 'u']

i = 0

('a'..'z').each do |c|
  i += 1
  vowels_hash[c] = i if vowels.include?(c)
end

puts vowels_hash
