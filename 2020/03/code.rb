# frozen_string_literal: true

INPUT = File.readlines(ARGV[0]).map { |line| line.strip.split('') }
SLOPES = [[1, 1], [3, 1], [5, 1], [7, 1], [1, 2]].freeze

def count_trees(input, slope)
  steps = (input.size - 1) / slope[1]
  grids_wide = ((steps * slope[0]).to_f / input.first.size).ceil
  full_grid = input.map { |row| row * grids_wide }

  trees = 0
  row = 0
  col = 0
  steps.times do
    row += slope[1]
    col += slope[0]
    trees += 1 if full_grid[row][col] == '#'
  end
  trees
end

part_two_answer = SLOPES.inject(1) { |product, slope| product * count_trees(INPUT, slope) }

puts "Part One: #{count_trees(INPUT, [3, 1])}"
puts "Part Two: #{part_two_answer}"
