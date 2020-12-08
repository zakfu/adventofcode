# frozen_string_literal: true

RULES = File.readlines(ARGV[0]).each_with_object({}) do |line, rules|
  rule_parts = line.split(' ').each_slice(4).to_a
  parent_bag_name = rule_parts.shift[0..1].join(' ')
  rules[parent_bag_name] = rule_parts.each_with_object({}) do |part, contents|
    next if part.size < 4

    bag_name = part[1..2].join(' ')
    contents[bag_name] = part[0].to_i
  end
end

BAG_NAME = (ARGV[1] || 'shiny gold')

def contents_of(bag)
  RULES[bag].keys.map do |b|
    [b] + contents_of(b)
  end.flatten
end

def count_bags(bag)
  RULES[bag].inject(0) do |count, (b, c)|
    count + c + count_bags(b) * c
  end
end

part_one = RULES.keys.map { |bag| contents_of(bag).include?(BAG_NAME) }.count(true)
puts "Part One: #{part_one}"

part_two = count_bags(BAG_NAME)
puts "Part Two: #{part_two}"
