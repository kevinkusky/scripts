#!/usr/bin/env ruby

puts "weird behavior?"

# if ARGV.length >= 2
#     title = ARGV[-1]

#     i = 0

#     while i < ARGV.length - 1
#         copy = []
#         ARGV[i].each do |row|
#             copy.push(row)
#             # row filter for desired hits
#             # unless row[0].start_with?('https://www.') || row[0].include?('zendesk')
#             #     copy.push(row)
#             # end
#         end

#         CSV.open("../../Desktop/#{title}", 'a+') do |csv|
#             copy.each do |row|
#                 csv << row
#             end
#         end

#         puts i
#         i += 1
#     end




# if ARGV.length == 2
#     file = CSV.read(ARGV[0])
#     title = ARGV[1]
#     file.each do |row|
#         unless row[0].start_with?('https://www.') || row[0].include?('zendesk')
#             copy.push(row)
#         end
#     end

#     CSV.open("../../Desktop/#{title}", "a+") do |csv|
#         copy.each do |row|
#             csv << row
#         end
#     end

# else
#     puts "Please run command as `csv_compiler.rb <csv_file_names> <result file name>`"
# end