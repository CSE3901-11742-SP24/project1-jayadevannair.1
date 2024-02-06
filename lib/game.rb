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
    play_area.combination(3).any? { |combo| Card.is_set?(combo[0], combo[1], combo[2]) }
  end

  # Main game loop
  def play_game
    puts "Welcome to the Game of Sets!"
    until deck.empty? && !any_sets?
      # Game logic goes here
      # show the play area
      # prompt the player to select a set
      puts "Game in progress..."
      # Placeholder for game logic
    end

    puts "Game over!"
    # Display final scores
  end
end