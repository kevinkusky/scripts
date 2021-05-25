#!/usr/bin/env ruby
require 'csv'

# Must Call in Directory we are Searching in.
if ARGV.length == 1
    exts = ['.jsx', '.erb', '.rb', '.js', '.html']
    search_files = [].tap do |arr|
        exts.each { |file_type| arr << Dir["**/*#{file_type}"] }
    end.uniq

    bad_links =[]

    links_file = CSV.read(ARGV[0]).each { |row| bad_links << row[0] }

    bad_links.uniq.each do |bad_url|
       
        # Listed items to ignore
        next if bad_url.include?('player.vimeo.com')

        # Flattened Files array
        search_files.flatten.each do |file|
            # conditional check for string inclusion in each file
            if File.open(file).read.include?(bad_url)
                puts file
                puts bad_url
                if !(bad_url.start_with?('https://www') || bad_url.start_with?('http://www'))
                    good_link = 'https://www.' + bad_url.split("://")[1].to_s + '/'
                    puts "prepend www to URL as #{good_link}"
                    # write to file then gsub then close
                    bad_url.gsub(bad_url, good_link)
                elsif bad_url.end_with?('.html')
                    good_link = bad_url + '/'
                    puts 'append slash char'
                else
                    puts "Bad Case with #{bad_url} in #{file}"
                end
            end
        end
        i += 1
    end
else
    puts "Please run command in Target Dir with <csv_file_path>"
end