require_relative '../lib/night_read'

class NightReadTest < Minitest::Test
  def test_exports_correct_output_to_file
    File.write('braille.txt', "0.0.0.0.0....00.0.0.00\n00.00.0..0..00.0000..0\n....0.0.0....00.0.0...")
    NightRead.new('braille.txt', 'output_message.txt').call
    assert_equal 'hello world', File.read('output_message.txt') # how does this read from here?!!
  end
end
