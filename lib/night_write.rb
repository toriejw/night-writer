require_relative 'translator'

class NightWrite
  attr_accessor :text_lines
  attr_reader :input_file, :output_file

  def initialize(input, output)
    @input_file = input
    @output_file = output
  end

  def call
    import_text
    content = Translator.night_write(text_lines) # should this be it's own method?
    export(content)
  end

  def import_text
    @text_lines = File.readlines(@input_file)
  end

  def export(content)
    File.write(output_file, content)
    file_characters = text_lines.flatten.each { |line| line.strip! }
                                        .join("")
                                        .size
    puts "Created '#{output_file}' containing #{file_characters} characters."
  end
end

running_file = ($PROGRAM_NAME == __FILE__)

if running_file
  input_file = ARGV[0]
  output_file = ARGV[1]

  NightWrite.new(input_file, output_file).call
end
