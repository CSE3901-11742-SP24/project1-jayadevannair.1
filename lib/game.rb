# frozen_string_literal: true

require_relative 'card'
require_relative 'grid'

class Game
  def initialize
    @deck = build_deck
    @play_area = []
    play_game
  end

  # Creates a full deck of shuffled Set cards
  def build_deck
    deck = []
    Card::NUMBERS.each do |number|
      Card::SHAPES.each do |shape|
        Card::SHADINGS.each do |shading|
          Card::COLORS.each do |color|
            deck << Card.new(number, shape, shading, color)
          end
        end
      end
    end
    deck.shuffle
  end

  # Checks if there are any sets in the play area
  def any_sets?
    @play_area.combination(3).any? do |combo|
      Card.is_set?(combo[0], combo[1], combo[2])
    end
  end

  # Return set or nil
  def hint_set
    list = @play_area.each_index.to_a
    list.combination(3).find { |combo| Card.is_set?(@play_area[combo[0]], @play_area[combo[1]], @play_area[combo[2]]) }
  end

  # Main game loop
  def play_game
    puts 'Welcome to the Game of Sets!'
    until @deck.empty? && !any_sets?
      @play_area += @deck.shift(12 - @play_area.length) if @play_area.length < 12

      if @deck.empty? && !any_sets?
        puts 'Game won!'
        break
      end

      Grid.print_grid(@play_area)

      puts "Cards in deck: #{@deck.length}"

      puts 'Choose one of the following options:'
      puts '1)3 more cards' if @deck.any?
      puts '0)To enter a set'
      puts '-1)Cheat :)'
      input = gets.chomp.to_i
      if input == 1
        @play_area += @deck.shift(3)
        next
      elsif input == -1
        set = hint_set
        if set
          Grid.print_grid(set.map { |index| @play_area[index] })
          puts "Hint set: #{set.join(', ')}"
          set.sort!
          @play_area.delete_at(set[2])
          @play_area.delete_at(set[1])
          @play_area.delete_at(set[0])

        else
          puts 'No sets found. Adding 3 more cards'
          @play_area += @deck.shift(3)
          #   puts 'No set found, add more cards!'
        end
        next
      end
      puts 'Please enter the indexs of the cards that make a set:'
      indexs = []

      3.times do |i|
        print "Index #{i + 1}: "
        input = gets.chomp.to_i
        indexs[i] = input
      end

      Grid.print_grid(indexs.map { |index| @play_area[index] })
      puts "You entered: #{indexs.join(', ')}"

      if !Card.is_set?(@play_area[indexs[0]], @play_area[indexs[0]], @play_area[indexs[0]])
        puts 'The slected cards are not a set!'
      else
        puts 'The slected cards are a set!'
        indexs.sort!
        @play_area.delete_at(indexs[2])
        @play_area.delete_at(indexs[1])
        @play_area.delete_at(indexs[0])
      end
    end

    puts 'Game over!'
    # Display final scores
  end
end

# Start the game
Game.new if __FILE__ == $PROGRAM_NAME
