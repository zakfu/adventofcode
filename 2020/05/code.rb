# frozen_string_literal: true

SEAT_KEYS = File.readlines(ARGV[0]).map(&:strip)

class Seat
  MAP = { 'F' => 0, 'B' => 1, 'L' => 0, 'R' => 1 }.freeze
  ROWS = (0..127).to_a.freeze
  COLS = (0..7).to_a.freeze

  attr_reader :id

  def initialize(key)
    @row_key, @col_key = key.split('').each_slice(7).to_a
    @row = find_seat(ROWS, @row_key)
    @col = find_seat(COLS, @col_key)
    @id = @row * 8 + @col
  end

  private

  def find_seat(seats, key)
    key.each { |l| seats = seats.each_slice(seats.size / 2).to_a[MAP[l]] }
    seats[0]
  end
end

ids = SEAT_KEYS.map { |seat_key| Seat.new(seat_key).id }

puts "Part One: #{ids.max}"
puts "Part Two: #{([*ids.min..ids.max] - ids)[0]}"
