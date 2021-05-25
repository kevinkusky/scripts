#!/usr/bin/env ruby
require 'csv'

def subfolder_search(dir_path)
    subfolder_paths = []

    if File.directory?(dir_path)
        Dir.each_child(dir_path) do |dir_item|
            next_search = dir_path + '/' + dir_item
            subfolder_paths << subfolder_search(next_search)
        end
    # Pull file types concerned with: jsx, js, erb, rb, html
    elsif (dir_path.end_with?('.jsx') || dir_path.end_with?('.js') || dir_path.end_with?('.erb') || dir_path.end_with?('.rb') || dir_path.end_with?('.js') || dir_path.end_with?('.html'))
        subfolder_paths << dir_path
    end

    return subfolder_paths
end

if ARGV.length == 2 && File.directory?(ARGV[1])
    links_file = CSV.read(ARGV[0])
    dir_path = ARGV[1] + "/app"
    search_files = subfolder_search(dir_path)
    i = 0

    links_file.each do |row|
        # Possible hardcoded URL in Col A
        bad_link = row[0]
        
        # Skip Headers and Dupes
        if bad_link == 'Address' || links_file[i - 1][0] == bad_link
            i += 1
            next
        end
        
        # Flattened Files array
        search_files.flatten.uniq.each do |file|
            # conditional check for string inclusion in each file
            # i.e: is this link hardcoded in?
            
            if File.open(file).include?(bad_link)
                puts "Match found!"
                # switch statement for each case on how to replace with gsub
                case bad_link
                when !bad_link.start_with('https://www')
                    good_link = 'htpps://www' + bad_link.split("://")[1].to_s
                    puts 'prepend www to URL'
                when bad_link.end_with('.html')
                    good_link = bad_link + '/'
                    puts 'append slash char'
                else
                    puts 'something went terribly wrong'
                end
                # good_link = bad_link + "/"
                # replace.gsub(bad_link, good_link)
            # else
            #     puts "no match"
            end
        end
        i += 1
    end
else
    puts "Please run command as <csv_file_path> <target_dir_path>"
end