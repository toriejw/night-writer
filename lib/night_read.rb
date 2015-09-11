require_relative 'translator'
require 'pry'

class NightRead
  def initialize(input, output)
    @input_file = input
    @output_file = output
  end

  def call
    import_text
    content = Translator.night_write(text_lines)
    export(content)
  end

end


running_file = ($PROGRAM_NAME == __FILE__)

if running_file
  input_file = ARGV[0]
  output_file = ARGV[1]

  NightRead.new(input_file, output_file).call
end

braille = File.readlines(input_file)

output = Translator.night_read(braille)

File.write(output_file, output)
puts "Created '#{output_file}' containing #{output.chars.count} characters."
