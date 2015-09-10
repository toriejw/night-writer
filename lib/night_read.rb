require_relative 'translator'

input_file = ARGV[0]
output_file = ARGV[1]

braille = File.readlines(input_file)

output = Translator.night_read(braille)

File.write(output_file, output)
puts "Created '#{output_file}' containing #{output.chars.count} characters."
