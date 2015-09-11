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

  def test_converts_multiple_text_lines_to_braille
    assert_equal "0.0.0.0.0....00.0.0.00\n00.00.0..0..00.0000..0\n....0.0.0....00.0.0...\n0.0.0.0.0...000.00000..00.0.\n00.00.0..0.....0..0...00.000\n....0.0.0.....0.0.0.000...0.",
      Translator.night_write(["hello world\n", "hello computer\n"])
  end

  def test_returns_blank_braille_character_for_spaces
    assert_equal "..\n..\n..", Translator.night_write([" "])
  end

  def test_handles_non_alphabetic_characters
    assert_equal "0.0.00..\n00.0.000\n....000.", Translator.night_write(["hey!"])
    assert_equal "..\n0.\n00", Translator.night_write(["?"])
  end

  def test_lines_do_not_go_over_40_text_characters
    assert_equal "................................................................................\n................................................................................\n................................................................................",
      Translator.night_write([" "*40])
    assert_equal "................................................................................\n................................................................................\n................................................................................\n..\n..\n..",
      Translator.night_write([" "*41])
  end

  def test_handles_capital_letters
    assert_equal "..0.\n..00\n.0..", Translator.night_write(["H"])
    assert_equal "..0...0.\n..00..00\n.0...0..", Translator.night_write(["HH"])
    assert_equal "...00.0.0.00\n..00.0000..0\n.0.00.0.0...", Translator.night_write(["World"])
    # assert_equal "H", Translator.night_read(["..0.\n..00\n.0.."])
  end


end
