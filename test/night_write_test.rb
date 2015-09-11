require_relative '../lib/night_write'

class NightWriteTest < Minitest::Test
  def test_imports_correct_input_file
    skip
  end

  def test_exports_correct_output_to_file
    File.write('message.txt', 'hello world')
    NightWrite.new('message.txt', 'braille.txt').call
    assert_equal "0.0.0.0.0....00.0.0.00\n00.00.0..0..00.0000..0\n....0.0.0....00.0.0...", File.read("braille.txt") # how does this read from here?!!
  end


end
