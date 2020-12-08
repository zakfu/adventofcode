# frozen_string_literal: true

class DuplicateInstuctionReceived < RuntimeError; end

INSTRUCTIONS = File.readlines(ARGV[0]).map do |i|
  op, arg = i.strip.split(' ')
  [op, arg.to_i]
end

def boot(instuctions)
  accumulator = 0
  index = 0
  complete = []

  loop do
    raise DuplicateInstuctionReceived, accumulator if complete.include?(index)

    complete << index

    i = instuctions[index]
    case i[0]
    when 'acc'
      accumulator += i[1]
      index += 1
    when 'jmp'
      index += i[1]
    when 'nop'
      index += 1
    end

    return accumulator if index == instuctions.size
  end
end

# Part One
print 'Part One: '
begin
  boot(INSTRUCTIONS)
rescue DuplicateInstuctionReceived => e
  puts e
end

# Part Two
print 'Part Two: '
index = 0
loop do
  ins = INSTRUCTIONS.dup
  ins.each_with_index do |(op, arg), i|
    next unless i > index && %w[jmp nop].include?(op)

    new_op = op == 'jmp' ? 'nop' : 'jmp'
    ins[i] = [new_op, arg]
    index = i
    break
  end

  begin
    result = boot(ins)
  rescue DuplicateInstuctionReceived
    next
  end

  puts result
  break
end
