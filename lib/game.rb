require_relative 'card'
require_relative 'grid'

# Represents the Game of Set, handling game initialization, the game loop, and game logic
class Game
  def initialize
    @deck = build_deck  # Initializes a shuffled deck of cards
    @play_area = []     # Initializes an empty play area
    play_game           # Starts the game loop upon instantiation
  end

  # Builds and returns a shuffled deck of Set cards
  def build_deck
    deck = []
    Card::NUMBERS.each do |number|  # Iterates over all possible card numbers
      Card::SHAPES.each do |shape|  # Iterates over all possible card shapes
        Card::SHADINGS.each do |shading|  # Iterates over all possible card shadings
          Card::COLORS.each do |color|  # Iterates over all possible card colors
            # Creates a new card with the current attributes and adds it to the deck
            deck << Card.new(number, shape, shading, color)
          end
        end
      end
    end
    deck.shuffle  # Shuffles the deck before returning
  end

  # Checks if there's at least one valid set in the play area
  def any_sets?
    @play_area.combination(3).any? do |combo|
      Card.is_set?(combo[0], combo[1], combo[2])  # Evaluates if a combination of 3 cards forms a set
    end
  end

  # Finds and returns a hint for a valid set in the play area, or nil if none exist
  def hint_set
    list = @play_area.each_index.to_a  # Gets an array of card indices in the play area
    # Finds the first combination of indices that form a valid set and returns it
    list.combination(3).find { |combo| Card.is_set?(@play_area[combo[0]], @play_area[combo[1]], @play_area[combo[2]]) }
  end

  # Contains the main game loop, handling user input and game progression
  def play_game
    puts 'Welcome to the Game of Sets!'
    until @deck.empty? && !any_sets?  # Continues until the deck is empty and no sets are in play
      # Fills the play area with cards from the deck if there are less than 12 cards
      @play_area += @deck.shift(12 - @play_area.length) if @play_area.length < 12

      # Checks for game completion condition
      if @deck.empty? && !any_sets?
        puts 'Game won!'
        break  # Exits the loop if the game is won
      end

      Grid.print_grid(@play_area)  # Displays the current play area

      # Displays game options to the player
      puts "Cards in deck: #{@deck.length}"
      puts 'Choose one of the following options:'
      puts '1)3 more cards' if @deck.any?  # Option to add more cards to the play area
      puts '0)To enter a set'  # Option to enter a set manually
      puts '-1)Cheat :)'  # Option to reveal a hint for a set
      input = gets.chomp.to_i  # Reads player input

      case input
      when 1
        # Adds 3 more cards to the play area from the deck
        @play_area += @deck.shift(3)
      when -1
        # Provides a hint for a set, or adds 3 more cards if none exist
        provide_hint_or_add_cards
      else
        # Handles the case where the player enters a set manually
        process_player_set_entry
      end
    end

    puts 'Game over!'  # End game message
  end

  private

  # Provides a hint for a set in the play area, or adds 3 cards if no set is found
  def provide_hint_or_add_cards
    set = hint_set
    if set
      # Prints the hint set and its indices
      Grid.print_grid(set.map { |index| @play_area[index] })
      puts "Hint set: #{set.join(', ')}"
      # Removes the hinted set from the play area
      set.sort!.reverse_each { |index| @play_area.delete_at(index) }
    else
      puts 'No sets found. Adding 3 more cards'
      @play_area += @deck.shift(3)  # Adds 3 more cards to the play area
    end
  end

  # Processes player input for manually entering a set
  def process_player_set_entry
    puts 'Please enter the indexes of the cards that make a set:'
    indexes = Array.new(3) do |i|
      print "Index #{i + 1}: "
      gets.chomp.to_i  # Reads each card index from the player
    end

    if indexes.uniq.length != indexes.length
      puts 'Invalid input!'
      return
    end

    # Displays the selected cards to the player for verification
    Grid.print_grid(indexes.map { |index| @play_area[index] })
    puts "You entered: #{indexes.join(', ')}"



    # Checks if the selected cards form a valid set
    if Card.is_set?(@play_area[indexes[0]], @play_area[indexes[1]], @play_area[indexes[2]])
      puts 'The selected cards are a set!'
      # Removes the selected set from the play area, starting with the highest index to avoid shifting issues
      indexes.sort.reverse_each { |index| @play_area.delete_at(index) }
    else
      puts 'The selected cards are not a set!'
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  Game.new  # Instantiates and starts a new Game of Set
end