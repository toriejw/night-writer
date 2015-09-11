require_relative 'translator'

class NightRead
  attr_reader :input_file, :output_file
  attr_accessor :braille
  def initialize(input, output)
    @input_file = input
    @output_file = output
    @braille
  end

  def call
    @braille = File.readlines(input_file)
    content = Translator.night_read(braille)
    export(content)
  end

  def export(content)
    File.write(output_file, content)
    puts "Created '#{output_file}' containing #{content.chars.count} characters."
  end
end


running_file = ($PROGRAM_NAME == __FILE__)

if running_file
  input_file = ARGV[0]
  output_file = ARGV[1]

  NightRead.new(input_file, output_file).call
end
