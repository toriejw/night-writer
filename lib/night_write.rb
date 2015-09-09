require_relative 'translator'

input_file = ARGV[0]
output_file = ARGV[1]

# read in file
text_array = File.readlines(input_file)

text = ''
text_array.each { |line| text << line }

# convert to braille
braille = Translator.night_write(text_array)

# output output_file
File.write(output_file, braille)

puts "Created '#{output_file}' containing #{text.chars.count - text_array.count} characters."


# `ruby night_write.rb ../test/fixtures/message.txt braille.txt`