# frozen_string_literal: true

INPUT = File.readlines(ARGV[0])

def part_one_valid?(line)
  min, max, char, _, password = line.split(/[ :-]/)
  count = password.count(char)
  count >= min.to_i && count <= max.to_i
end

def part_two_valid?(line)
  positions, char, _, password = line.split(/[ :]/)
  pos1, pos2 = positions.split('-').map { |p| p.to_i - 1 }
  [password[pos1], password[pos2]].count(char) == 1
end

part_one_valid_passwords = 0
part_two_valid_passwords = 0

INPUT.each do |line|
  part_one_valid_passwords += 1 if part_one_valid?(line)
  part_two_valid_passwords += 1 if part_two_valid?(line)
end

puts "Part One: #{part_one_valid_passwords}"
puts "Part Two: #{part_two_valid_passwords}"
