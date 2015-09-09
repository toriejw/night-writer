require_relative '../lib/translator'

class TranslatorTest < Minitest::Test

  def test_converts_text_characters_to_braille
    assert_equal "0.\n..\n..", Translator.night_write(["a"])
    assert_equal "0.\n00\n..", Translator.night_write(["h"])
  end

  def test_converts_text_words_to_braille
    assert_equal "0.0.0.0.0....00.0.0.00\n00.00.0..0..00.0000..0\n....0.0.0....00.0.0...",
      Translator.night_write(["hello world"])
  end

  def test_exports_to_file
    skip
  end

  def test_converts_multiple_text_lines_to_braille
    assert_equal "0.0.0.0.0....00.0.0.00..\n00.00.0..0..00.0000..0..\n....0.0.0....00.0.0.....\n0.0.0.0.0...000.00000..00.0...\n00.00.0..0.....0..0...00.000..\n....0.0.0.....0.0.0.000...0...",
      Translator.night_write(["hello world\n", "hello computer\n"])
  end

  def test_returns_blank_braille_character_for_non_lower_case_letters
    assert_equal "..\n..\n..", Translator.night_write(["!"])
    assert_equal "0.0.00..\n00.0.0..\n....00..",
      Translator.night_write(["hey!"])
  end

end
