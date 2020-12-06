# frozen_string_literal: true

SEAT_KEYS = File.readlines(ARGV[0]).map(&:strip)

def key_to_int(key)
  key.gsub(/[FBLR]/, 'F' => '0', 'B' => '1', 'L' => '0', 'R' => '1').to_i(2)
end

ids = SEAT_KEYS.map do |key|
  key_to_int(key[0,7]) * 8 + key_to_int(key[7,3])
end

puts "Part One: #{ids.max}"
puts "Part Two: #{([*ids.min..ids.max] - ids)[0]}"
