#!/usr/bin/env ruby
require 'csv'

# Must Call in Directory we are Searching in.
if ARGV.length == 1
    file_types = ['.jsx', '.erb', '.rb', '.js', '.html']

    search_files = [].tap do |arr|
        file_types.each { |type| arr << Dir["**/*#{type}"] }
    end.uniq

    bad_links = []

    CSV.read(ARGV[0]).each { |row| bad_links << row[0] }

    bad_links.uniq.each do |bad_url|
        next if bad_url.include?('player.vimeo.com')

        search_files.flatten.each do |file|
            # conditional check for string inclusion in each file

            file_contents = File.open(file).read

            if file_contents.include?(bad_url)
                puts "Current File: #{file}; Current Url: #{bad_url}"

                if !(bad_url.start_with?('https://www') || bad_url.start_with?('http://www'))
                    good_url = 'https://www.' + bad_url.split("://")[1].to_s + '/'
                    puts "prepend www to URL as #{good_link}"
                    
                    # write to file then gsub then close
                    corrected_content = file_contents.gsub(bad_url, good_url)
                    File.open(file, "w"){|f| f.puts corrected_content}
                elsif bad_url.end_with?('.html')
                    good_url = bad_url + '/'
                    puts 'append slash char'

                    corrected_content = file_contents.gsub(bad_url, good_url)
                    File.open(file, "w"){|f| f.puts corrected_content}
                else
                    puts "Bad Case with #{bad_url} in #{file}"
                end
            end
        end
        File.close(file)
    end
else
    puts "Please run command in Target Dir with <csv_file_path>"
end