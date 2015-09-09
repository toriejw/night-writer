require 'pry'

class Translator
  BRAILLE_MAP = {"a" => [1],
                 "b" => [1, 3],
                 "c" => [1, 2],
                 "d" => [1, 2, 4],
                 "e" => [1, 4],
                 "f" => [1, 2, 3],
                 "g" => [1, 2, 3, 4],
                 "h" => [1, 3, 4],
                 "i" => [2, 3],
                 "j" => [2, 3, 4],
                 "k" => [1, 5],
                 "l" => [1, 3, 5],
                 "m" => [1, 2, 5],
                 "n" => [1, 2, 4, 5],
                 "o" => [1, 4, 5],
                 "p" => [1, 2, 3, 5],
                 "q" => [1, 2, 3, 4, 5],
                 "r" => [1, 3, 4, 5],
                 "s" => [2, 3, 5],
                 "t" => [2, 3, 4, 5],
                 "u" => [1, 5, 6],
                 "v" => [1, 3, 5, 6],
                 "w" => [2, 3, 4, 6],
                 "x" => [1, 2, 5, 6],
                 "y" => [1, 2, 4, 5, 6],
                 "z" => [1, 4, 5, 6]
                }

  def self.night_write(string_array)
    braille_lines = string_array.map { |line| line_to_braille(line.downcase) }
    combine_lines(braille_lines)
  end

  def self.line_to_braille(line)
    braille_chars = []
    line.chars.each { |char| braille_chars << self.char_to_braille(char) }
    self.join_braille(braille_chars)
  end

  def self.char_to_braille(char)
    braille = "." * 6
    BRAILLE_MAP[char].each { |dot| braille[dot - 1] = "0" } if BRAILLE_MAP[char]
    braille
  end

  def self.join_braille(braille_chars)
    line1, line2, line3 = "", "", ""
    braille_chars.each do |char|
      line1 << char[0..1]
      line2 << char[2..3]
      line3 << char[4..5]
    end

    line = (line1 + "\n" + line2 + "\n" +line3)
  end

  def self.combine_lines(lines)
    output = ""
    lines.each { |line| output << line + "\n"}
    output.chomp
  end
end
