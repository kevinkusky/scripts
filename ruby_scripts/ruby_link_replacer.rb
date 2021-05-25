#!/usr/bin/env ruby
require 'csv'

def subfolder_search(dir_path)
    subfolder_paths = []

    if File.directory?(dir_path)
        Dir.each_child(dir_path) do |dir_item|
            next_search = dir_path + '/' + dir_item
            subfolder_paths << subfolder_search(next_search)
        end
    # Pull file types concerned with: jsx, js, erb, rb, html, php
    elsif (dir_path.end_with?('.jsx') || dir_path.end_with?('.js') || 
        dir_path.end_with?('.erb') || dir_path.end_with?('.rb') || dir_path.end_with?('.js') || 
        dir_path.end_with?('.php') || dir_path.end_with?('.html'))
        
        subfolder_paths << dir_path
    end

    return subfolder_paths
end

if ARGV.length == 2 && File.directory?(ARGV[1])
    links_file = CSV.read(ARGV[0])
    search_files = subfolder_search(ARGV[1])
    i = 0

    links_file.each do |row|
        # Possible hardcoded URL in Col  A
        bad_link = row[0]
        
        # Skip Headers and Dupes
        if bad_link == 'Address' || links_file[i - 1][0] == bad_link || bad_link.include?('player.vimeo.com')
            i += 1
            next
        end
        
        # Flattened Files array
        search_files.flatten.each do |file|
            # conditional check for string inclusion in each file
            if File.open(file).read.include?(bad_link)
                if !(bad_link.start_with?('https://www') || bad_link.start_with?('http://www'))
                    good_link = 'https://www.' + bad_link.split("://")[1].to_s
                    puts "prepend www to URL as #{good_link}"
                    # bad_link.gsub(bad_link, good_link)
                elsif bad_link.end_with?('.html')
                    good_link = bad_link + '/'
                    puts 'append slash char'
                else
                    puts "Bad Case with #{bad_link} in #{file}"
                end
            end
        end
        i += 1
    end
else
    puts "Please run command as <csv_file_path> <target_dir_path>"
end