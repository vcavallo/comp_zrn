
# Initial planning/brainstorming
#
# 1.  import and store csv as nested arrays - each row is an array 
#     in the entire puzzle array
#
# 2.  define individual traversers that can start at a letter and traverses 
#     a number of steps in a single direction (up/down/left/right 
#     and the 4 diagonals)
#       2a. it has to be able to stop if it hits the end of the puzzle! 
#       2b. each traverser returns a string of letters found
#       ( thinking ahead to refactoring: it would be best if these traversers 
#       stopped when the next letter it finds is not the next letter in the string
#       in question... )
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
 