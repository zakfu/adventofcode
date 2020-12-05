# frozen_string_literal: true

PASSPORTS = File.read(ARGV[0]).split("\n\n").map do |passport_string|
  passport_string.split(/[ \n]/).each_with_object({}) do |field, hash|
    a = field.split(':')
    hash[a[0]] = a[1]
  end
end

REQUIRED_FIELDS = %w[byr iyr eyr hgt hcl ecl pid].freeze
EYE_COLORS = %w[amb blu brn gry grn hzl oth].freeze

def valid_field?(key, value)
  case key
  when 'byr'
    value.to_s.size == 4 && value.to_i >= 1920 && value.to_i <= 2002
  when 'iyr'
    value.to_s.size == 4 && value.to_i >= 2010 && value.to_i <= 2020
  when 'eyr'
    value.to_s.size == 4 && value.to_i >= 2020 && value.to_i <= 2030
  when 'hgt'
    unit = value.slice!(-2, 2)
    height = value.to_i
    case unit
    when 'cm'
      height >= 150 && height <= 193
    when 'in'
      height >= 59 && height <= 76
    else
      false
    end
  when 'hcl'
    !value.match(/^#[0-9a-f]{6}$/).nil?
  when 'ecl'
    EYE_COLORS.include?(value)
  when 'pid'
    !value.match(/^[0-9]{9}$/).nil?
  when 'cid'
    true # do not validate
  else
    puts "Unknown field: #{key}"
    exit 1
  end
end

part_one_valid_passports = 0
part_two_valid_passports = 0

PASSPORTS.each do |passport|
  missing_fields = REQUIRED_FIELDS - passport.keys
  next unless missing_fields.empty?

  part_one_valid_passports += 1
  next unless passport.all? { |k, v| valid_field?(k, v) }

  part_two_valid_passports += 1
end

puts "Part One: #{part_one_valid_passports}"
puts "Part Two: #{part_two_valid_passports}"
