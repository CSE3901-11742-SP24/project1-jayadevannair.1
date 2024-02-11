# frozen_string_literal: false

# The Grid class represents a grid layout to display cards with various properties.
class Grid
  # Prints a grid layout of cards with visual attributes.
  def self.print_grid(cards)
    c = cards.clone # Creates a shallow copy of the cards array to avoid modifying the original array.
    i = 0 # Counter for card numbering in the grid.

    # Loops until all cards have been processed and printed.
    until c.empty?
      line = c.shift([6, c.length].min) # Retrieves up to 6 cards from the array to form a line in the grid.

      # Initializes an array to hold textual representation of each card.
      cardsText = []
      line.each_with_index do |card, index|
        cardsText[index] = card_as_text(card) # Converts each card to its textual representation.
      end

      # Prints each row of the card's textual representation.
      7.times do |row|
        cardsText.each_with_index do |card, index|
          # Adds color to the card text and prints it with spacing for alignment.
          print "#{add_color(card[(row * 10)..9 + (row * 10)], line[index])}    "
        end
        $stdout.flush
        puts ''
      end

      # Prints card indices below each card for identification.
      line.length.times do
        print "    #{'%2d' % i}        "
        i += 1
      end

      $stdout.flush
      puts ''
    end
    nil
  end

  # Generates a textual representation of a card based on its attributes.
  def self.card_as_text(card)
    shape = card_shape(card) # Determines the shape symbol for the card.
    text = card_top_bottom(card) + card_side(card) # Generates the top and side border based on shading.

    # Generates the sides and content of the card based on shading and number.
    l1, l2, l3 = Array.new(3) { card_side(card) }
    l2[4..5] = shape if card.number == 1 || card.number == 3
    if card.number == 2 || card.number == 3
      l1[2..3] = shape
      l3[6..7] = shape
    end

    # Constructs the complete card text by concatenating all parts.
    text += l1 + l2 + l3 + card_side(card) + card_top_bottom(card)
    text
  end

  # Generates the top or bottom border of a card based on its shading.
  def self.card_top_bottom(card)
    case card.shading
    when :solid then '██████████'
    when :striped then '##########'
    else '          '
    end
  end

  # Generates the side borders of a card based on its shading.
  def self.card_side(card)
    case card.shading
    when :solid then '█        █'
    when :striped then '#        #'
    else '          '
    end
  end

  # Determines the shape symbol for a card based on its shape attribute.
  def self.card_shape(card)
    case card.shape
    when :diamond then '<>'
    when :squiggle then '~~'
    else '()'
    end
  end

  # Adds color to a given text based on the card's color attribute.
  def self.add_color(text, card)
    # Determines the ANSI color code based on the card's color attribute.
    color_code = case card.color
                 when :red then "\e[31m" # Red
                 when :green then "\e[32m" # Green
                 else "\e[35m" # Magenta
                 end
    # Wraps the text in the appropriate ANSI color codes, resetting the color at the end.
    "#{color_code}#{text}\e[0m"
  end
end
