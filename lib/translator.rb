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
                 "z" => [1, 4, 5, 6],
                 "!" => [3, 4, 5],
                 "'" => [5],
                 "," => [3],
                 "-" => [5, 6],
                 "." => [3, 4, 6],
                 "?" => [3, 5, 6]
                }

  def self.night_write(string_array)
    string_array.each_with_index do |line, index|
      string_array[index] = split_line(line) if too_long?(line)
    end
    braille_lines = string_array.flatten.map { |line| line_to_braille(line.chomp) }
    combine_lines(braille_lines)
  end

  def self.night_read(braille_array)
    braille_lines = separate_lines(braille_array)
    text = ''
    braille_lines.map do |line|
      line_chars = separate_chars(line.flatten)
      text << translate(line_chars)
    end
    text
  end

  def self.translate(chars)
    chars.each do |braille_char|
      map = map_to_text(braille_char)
      # return key for value map




    end
  end

  def self.map_to_text(braille_char)
    map = []
    braille_char.chars.each_with_index do |char, index|
      map << index + 1 if char == "0"
    end
    map
  end

  def self.separate_lines(array)
    braille_lines = []
    array.each_with_index do |_, index|
      next if index % 3 != 0
      braille_lines << [array[index..index + 2]]
    end
    braille_lines
  end

  def self.separate_chars(line)
    braille_chars = []
    while line[0].length > 0
      braille_chars << line[0].slice!(0..1) + line[1].slice!(0..1) + line[2].slice!(0..1)
    end
    braille_chars
  end

  def self.too_long?(line)
    line.length > 40
  end

  def self.split_line(line)
    lines = line.scan(/.{1,40}/)
  end

  def self.line_to_braille(line)
    braille_chars = []
    line.each_char { |char| braille_chars << self.char_to_braille(char) }
    self.join_braille(braille_chars.flatten)
  end

  def self.char_to_braille(char)
    if BRAILLE_MAP[char]
      map_to_braille(BRAILLE_MAP[char])
    elsif BRAILLE_MAP[char.downcase]
      lower_case = map_to_braille(BRAILLE_MAP[char.downcase])
      [".....0", lower_case]
    else
      map_to_braille([])
    end
  end

  def self.map_to_braille(numbers)
    braille = "." * 6
    numbers.each do |dot|
      braille[dot - 1] = "0"
    end
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

Translator.night_write([" "*41])
