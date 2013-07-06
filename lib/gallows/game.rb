module Gallows
  class Game
    def initialize(output=$stdout, input=$stdin)
      @output = output
      @input = input
      @errors = 0
    end
    def init
      @secret_word = set_rand_word
      @errors = 0
      @win = false
      @public_str = "-"*@secret_word.length
    end

    def set_rand_word
      File.readlines("words.txt").sample
    end

    def print_result
      @output.puts "----------"
      @output.puts "|        |"
      @output.puts "|        O"   if (@errors > 0)
      @output.puts "|"            if (@errors == 0)
      @output.puts "|        |"   if (@errors == 2)
      @output.puts "|       /|"   if (@errors == 3)
      @output.puts "|       /|\\" if (@errors >= 4)
      @output.puts "|"            if (@errors < 5 )
      @output.puts "|       /"    if (@errors == 5)
      @output.puts "|       /\\"  if (@errors == 6)
      @output.puts "|"
      @output.puts "=========="
      @output.puts "count errors - #{@errors}" 
    end
    def check_letter(char)
      @secret_word.length.times { |i| @public_str[i] = char if (@secret_word[i] == char)}
      @secret_word.include?(char)
    end
    def procces
      @output.puts "Please enter the letter"
      char = @input.gets.chomp
      @errors += 1 unless check_letter(char[0])
      print_result
      @public_str.include?("-") ? @output.puts(@public_str) : @win = true
      procces if continue_game
    end

    def continue_game
      (@errors < 6) && (@win == false)
    end

    def run
      init
      procces
      @win ? @output.puts("Congratulations you WIN!!!!! secret word is #{@public_str}") : @output.puts("You Lose! secret word is #{@secret_word}")
      @output.puts "Do you want to play again?(y/n)"
      answer = @input.gets.chomp
      run if (answer == "y")
    end
  end
end 