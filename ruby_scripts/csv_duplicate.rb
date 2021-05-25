#!/usr/bin/env ruby
require 'csv'

if ARGV.length == 2
    file = CSV.read(ARGV[0])
    title = ARGV[1]
    copy = []

    file.each do |row|
        copy.push(row)
    end


    # 'a+' to add to file if already exists

    CSV.open("../../Desktop/#{title}", "w") do |csv|
        copy.each do |row|
            csv << row
        end
    end

else
    puts "Please run command as `csv_duplicate.rb <csv_file_name> <new file name>`"
end