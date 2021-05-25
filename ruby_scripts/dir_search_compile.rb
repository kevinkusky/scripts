#!/usr/bin/env ruby
require 'csv'

if ARGV.length == 2
    dir_path = ARGV[0]
    title = ARGV[1]

    Dir.each_child(dir_path) do |file|
        next if file.start_with?('.') || file.start_with?('..')

        file_path = dir_path + '/' + file
        copy = []

        puts "CURRENT FILE: #{file_path}"
        
        curr_csv = CSV.read(file_path)

        curr_csv.each do |row|
            copy.push(row) unless (row[0].include?('//www.') || row[0].include?('zendesk'))
        end

        # Remove first header row if compile file already exists
        copy.shift if File.file?("../../Desktop/#{title}")

        CSV.open("../../Desktop/#{title}", "a+") do |csv|
            copy.each { |row| csv << row }
        end
    end
else
    puts "Please run command as `./dir_search_compile.rb <list_csv_file_paths> <resultant file name>`"
end
