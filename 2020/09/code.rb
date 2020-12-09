# frozen_string_literal: true

INPUT = File.readlines(ARGV[0]).map(&:to_i)
WINDOW_SIZE = ARGV[1].to_i

class Array
  def includes_pair_for?(target)
    each { |x| each { |y| return true if (x + y) == target && x != y } }
    false
  end

  def find_invalid(window_size)
    each_cons(window_size + 1) do |window|
      n = window.pop
      return n unless window.includes_pair_for?(n)
    end
  end

  def find_weekness(invalid)
    each_with_index do |n, i|
      numbers = [n]
      loop do
        numbers << self[i + numbers.size]
        return numbers.min + numbers.max if numbers.sum == invalid
        break if numbers.sum > invalid
      end
    end
  end
end

invalid = INPUT.find_invalid(WINDOW_SIZE)
weakness = INPUT.find_weekness(invalid)

puts "Part One: #{invalid}"
puts "Part Two: #{weakness}"
