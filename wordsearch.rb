
# Initial planning/brainstorming
#
# 1.  a. import and store csv as nested arrays - each row is an array 
#     in the entire puzzle array
#     b. import wordlist and store as array
#
# 2.  define individual traversers that can start at a letter and traverses 
#     a number of steps in a single direction (up/down/left/right 
#     and the 4 diagonals)
#       2a. it has to be able to stop if it hits the end of the puzzle! 
#       2b. each traverser returns a string of letters found
#       ( thinking ahead to refactoring: it would be best if these traversers 
#       stopped when the next letter it finds is not the next letter in the 
#       string in question... )
#
# 3.  define a search_from_letter method that starts at a letter and traverses 
#     all directions.
#       3a. this method takes a string as an argument. if one of the traversers
#       finds that string, it is returned. otherwise it returns nil.
#
# 4.  import and store the word list as an array where each item is a single-word 
#     string.
#
# 5.  iterate over this word list searching the puzzle for each word. if the word
#     is found, save it to a hash as a key. with value '1'. if the key is already
#     present in the hash instead increment its value by 1.
#
# 6.  output this hash to a an output text file with the numbers of word 
#     occurances formatted properly.

require 'CSV'

class Puzzle

  attr_reader :data, :wordlist

  def initialize(puzzle, wordlist)
    @data = load_puzzle(puzzle)
    @wordlist = load_wordlist(wordlist)
  end

  def load_puzzle(file)
    data = []
    CSV.foreach(file) do |row|
      data << row
    end
    data
  end

  def load_wordlist(file)
    words = []
    File.open(file).each do |line|
      words << line.chomp
    end
    words
  end

  def get_indexes_in_row(row, letter_to_find)
    results = []
    self.data[row].each_with_index do |letter, index|
      if letter == letter_to_find
        results << [row,index]
      end
      # results << index if letter == letter_to_find
    end
    if !results.empty?
      return results
    else
      return nil
    end
  end

  def search_word(word)
    letter = word[0]
    results = []
    self.data.each_with_index do |row, index|
      results << get_indexes_in_row(index, letter)
    end
    results.compact
  end

  # this should be used to find starting point, by row, for traversing.
  # next we'd call all traversals on this index.

end #end puzzle class

class Search

  attr_accessor :puzzle

  def initialize(puzzle)
    @puzzle = puzzle
  end

  def search_word(puzzle, word)
    letter = word[0]
    puzzle.data.each_with_index do |row, index|
      get_indexes_in_row(index, letter)
    end
  end

end

class Traverse
  attr_accessor :position, :row, :col

  # Traverse.new(a.get_indexes_in_row(1,"V").first)
  # => #<Traverse:0x007fd97a845958 @row=1, @col=18>

  def initialize(array)
    @row = array[0]
    @col = array[1]
  end

  # def arrayify_position
  #   [self.row, self.col]
  # end

  def all_traversals(length)
    results = []

    results << row_up(length)
    results << up_right(length)
    results << col_right(length)
    results << down_right(length)
    results << row_down(length)
    results << down_left(length)
    results << col_left(length)
    results << up_left(length)

    results
  end

  def row_down(length)
    result = []
    length.times do 
      result << [self.row += 1, col]
    end
    length.times {self.row -= 1}
    result
  end

  def row_up(length)
    result = []
    length.times do 
      result << [self.row -= 1, col]
    end
    length.times {self.row += 1}
    result
  end

  def col_right(length)
    result = []
    length.times do 
      result << [row, self.col += 1]
    end
    length.times {self.col -= 1}
    result
  end

  def col_left(length)
    result = []
    length.times do 
      result << [row, self.col -= 1]
    end
    length.times {self.col += 1}
    result
  end

  def down_right(length)
    result = []
    length.times do 
      result << [self.row += 1, self.col += 1]
    end
    length.times do 
      self.row -= 1
      self.col -= 1
    end
    result
  end

  def up_right(length)
    result = []
    length.times do 
      result << [self.row -= 1, self.col += 1]
    end
    length.times do 
      self.row += 1
      self.col -= 1
    end
    result
  end

  def down_left(length)
    result = []
    length.times do 
      result << [self.row += 1, self.col -= 1]
    end
    length.times do 
      self.row -= 1
      self.col += 1
    end
    result
  end

  def up_left(length)
    result = []
    length.times do 
      result << [self.row -= 1, self.col -= 1]
    end
    length.times do 
      self.row += 1
      self.col += 1
    end
    result
  end

end

puzzle = Puzzle.new("puzzle13.csv", "wordlist13.txt")
# each row of the puzzle:
puzzle.data.each do
  # ? 
end


  # Traverse.new(a.get_indexes_in_row(1,"V").first)
  # => #<Traverse:0x007fd97a845958 @row=1, @col=18>