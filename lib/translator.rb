require_relative 'braille_map'

class Translator
  def self.night_write(string_array)
    string_array.each_with_index do |line, index|
      string_array[index] = split_line(line) if too_long?(line)
    end
    braille_lines = string_array.flatten.map { |line| line_to_braille(line.chomp) }
    combine_lines(braille_lines)
  end

  def self.night_read(braille_array)
    braille_lines = separate_lines(braille_array)
    text = create_text_lines(braille_lines)
    add_capitals(text)
    text = split_line(text).join("\n") if too_long?(text)
    text.chop
  end

  def self.create_text_lines(braille_lines)
    text = ''
    braille_lines.map do |line|
      line_chars = separate_chars(line.flatten)
      text << translate(line_chars)
    end
    text
  end

  def self.translate(chars)
    line = ''
    chars.each_with_index do |braille_char, index|
      map = map_to_text(braille_char)
      line << BRAILLE_MAP.key(map)
    end
    line
  end

  def self.add_capitals(text)
    text.each_char.with_index do |char, index|
      next unless char == "^"
      text[index + 1] = text[index + 1].upcase
      text[index] = ""
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
    line.scan(/.{1,40}/)
  end

  def self.line_to_braille(line)
    braille_chars = []
    line.each_char { |char| braille_chars << char_to_braille(char) }
    join_braille(braille_chars.flatten)
  end

  def self.char_to_braille(char)
    if BRAILLE_MAP[char]
      map_to_braille(BRAILLE_MAP[char])
    elsif BRAILLE_MAP[char.downcase]
      lower_case = map_to_braille(BRAILLE_MAP[char.downcase])
      [".....0", lower_case]
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
