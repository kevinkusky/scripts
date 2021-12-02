#!/usr/bin/env ruby
require 'csv'
require 'httparty'

puts "Run the command correctly you dork" unless ARGV.length == 2

course_ids = [].tap do |arr|
  CSV.read(ARGV[0]).each { |row| arr << row }
end

url = ARGV[1]