#!/usr/bin/env ruby
require 'csv'

file = CSV.read(ARGV[0])
row_total = 0

file.each do |row|
    row_total += 1
end

puts row_total