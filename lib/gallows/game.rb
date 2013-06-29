module Gallows
  class Game
    attr_accessor :secret_word, :public_str
    def start
      puts "hi"
    end
    def initialize(output, input)
      @output = output
      @input = input
      @words = ["виселица","пшеница","ромашка","двигатель","гороскоп","ароматизатор"]
      @errors = 0
      @tries = 0
      @win = false
    end
    def set_rand_word
      @secret_word = @words.sample
      @public_str = "-"*@secret_word.length
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
      @tries += 1
      @secret_word.length.times { |i| @public_str[i] = char if (@secret_word[i] == char)}
      @secret_word.include?(char)
    end
    def run
      initialize($stdout, $stdin)
      set_rand_word
      loop do
        @output.puts "Please enter the letter"
        char = @input.gets
        @errors += 1 unless check_letter(char[0])
        print_result
        @public_str.include?("-") ? @output.puts(@public_str) : @win = true
        break if ((@errors >= 6) || (@win)) 
      end
      @win ? @output.puts("Congratulations you WIN!!!!! secret word is #{@public_str}") : @output.puts("You Lose! secret word is #{@secret_word}")
      @output.puts "Do you want to play again?(y/n)"
      answer = @input.gets
      run if (answer[0] == "y")
    end
  end
end