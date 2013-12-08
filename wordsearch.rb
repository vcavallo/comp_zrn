
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
      results << index if letter == letter_to_find
    end
    if !results.nil?
      results
    else
      nil
    end
  end  
  # this should be used to find starting point, by row, for traversing.
  # next we'd call all traversals on this index.

  # do I need a variable like position = "5,2"
  # which i would split at comma and send to data[5][2]?

  def get_down_letter(row, column)
    data[row+1][column]
  end


  # def find_down(word_to_find)
  #   "FQQ"
  #   start = word[0]
  #   # in each row of the puzzle, get_indexes_in_row(row, start)
  #   step_down
  # end

  # def step_down(data)
  #   # add 1 to data[index]
  #   # return new absolute index
  # end

end #end puzzle class

class Traverse
  attr_accessor :position

  def initialize(row,col)
    @position = "#{row},#{col}"
  end

  def arrayify_position
    [self.position.split(",").first.to_i, self.position.split(",").last.to_i]
  end

  # I STOPPED RIGHT HERE

  def increment_row(arrayified_position)
    
  end

end