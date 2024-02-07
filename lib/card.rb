# frozen_string_literal: true

class Card
  # Constants for the valid options for each attribute
  NUMBERS = [1, 2, 3].freeze
  SHAPES = %i[diamond squiggle oval].freeze
  SHADINGS = %i[solid striped open].freeze
  COLORS = %i[red green purple].freeze

  # Reader methods for card attributes
  attr_reader :number, :shape, :shading, :color

  # Initializes a new card with the given attributes
  def initialize(number, shape, shading, color)
    @number = number
    @shape = shape
    @shading = shading
    @color = color

    validate!
  end

  # Ensures that the card has valid attributes
  def validate!
    raise ArgumentError, 'Invalid number' unless NUMBERS.include?(@number)
    raise ArgumentError, 'Invalid shape' unless SHAPES.include?(@shape)
    raise ArgumentError, 'Invalid shading' unless SHADINGS.include?(@shading)
    raise ArgumentError, 'Invalid color' unless COLORS.include?(@color)
  end

  # Checks if three cards make a set
  def self.is_set?(card1, card2, card3)
    NUMBERS.all? { |_attr| all_same_or_all_different?(card1.number, card2.number, card3.number) } &&
      SHAPES.all? { |_attr| all_same_or_all_different?(card1.shape, card2.shape, card3.shape) } &&
      SHADINGS.all? { |_attr| all_same_or_all_different?(card1.shading, card2.shading, card3.shading) } &&
      COLORS.all? { |_attr| all_same_or_all_different?(card1.color, card2.color, card3.color) }
  end

  # Helper method to check if all attributes are the same or all different
  def self.all_same_or_all_different?(*args)
    args.uniq.size == 1 || args.uniq.size == args.size
  end
end
