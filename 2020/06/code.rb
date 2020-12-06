# frozen_string_literal: true

GROUPS = File.read(ARGV[0]).split("\n\n")

part_one_answer = GROUPS.map { |g| g.gsub(/\W+/, '').split('').uniq.size }.sum

part_two_answer = GROUPS.map do |group|
  group.split("\n").map do |person|
    person.split('')
  end.inject(:&).size
end.sum

puts "Part One: #{part_one_answer}"
puts "Part Two: #{part_two_answer}"
