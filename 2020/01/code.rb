# frozen_string_literal: true

INPUT = File.readlines(ARGV[0]).map(&:to_i)

TARGET = (ARGV[1] || 2020).to_i

catch(:found) do
  INPUT.each do |x|
    INPUT.each do |y|
      if (x + y) == TARGET
        puts "Part One: #{x * y}"
        throw(:found)
      end
    end
  end
end

catch(:found) do
  INPUT.each do |x|
    INPUT.each do |y|
      INPUT.each do |z|
        if (x + y + z) == TARGET
          puts "Part Two: #{x * y * z}"
          throw(:found)
        end
      end
    end
  end
end
