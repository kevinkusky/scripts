#!/usr/bin/env ruby
require 'csv'

def subfolder_search(dir_path)
    subfolder_paths = []

    if File.directory?(dir_path)
        Dir.each_child(dir_path) do |dir_item|
            next_search = dir_path + '/' + dir_item
            subfolder_paths << subfolder_search(next_search)
        end
    elsif (dir_path.end_with?('.jsx') || dir_path.end_with?('.erb') || dir_path.end_with?('.rb') || dir_path.end_with?('.js') || dir_path.end_with?('.html'))
        subfolder_paths << dir_path
    end

    return subfolder_paths
end

if ARGV.length == 2 && File.directory?(ARGV[1])
    links_file = CSV.read(ARGV[0])
    dir_path = ARGV[1] + "/app/views"
    search_files = subfolder_search(dir_path)

    links_file.each do |row|
        # Skip Headers - Current data formated as such:
        next if row[0] == 'Address'

        # Possible hardcoded URL in Col A
        bad_link = row[0]
        
        # Flattened Files array
        search_files.flatten().each do |file|
            # conditional check for string inclusion in each file
            # i.e: is this link hardcoded in?
            # puts file.respond_to?('each')
            if File.open(file).include?(bad_link)
                puts "Match found!"
                # good_link = bad_link + "/"
                # gsub method to replace matched condition
                # replace.gsub(bad_link, good_link)
            end
        end
    end
else
    puts "Please run command as <csv_file_path> <target_dir_path>"
end