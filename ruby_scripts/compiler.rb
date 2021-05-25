#!/usr/bin/env ruby
require 'csv'

if ARGV.length >= 2
    title = ARGV[-1]
    i = 0

    while i < ARGV.length - 1
        copy = []

        CSV.read(ARGV[i], liberal_parsing: true, encoding: "iso-8859-1").each do |row|
            # row filter for desired hits
            # .html needed too?
            copy.push(row) unless (row[0].include?('//www.') || row[0].include?('zendesk'))
        end

        # Remove first header row if compile file already exists
        copy.shift if File.file?("../../Desktop/#{title}")

        CSV.open("../../Desktop/#{title}", "a+") do |csv|
            copy.each { |row| csv << row }
        end

        i += 1
    end
else
    puts "Please run command as `./csv_compiler.rb <list_csv_file_paths> <resultant file name>`"
end