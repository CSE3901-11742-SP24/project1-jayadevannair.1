# frozen_string_literal: false

class Grid
  def self.print_grid(cards)
    c = cards.clone
    i = 0
    until c.empty?
      line = c.shift([6, c.length].min)
      cardsText = []
      line.each_with_index do |card, index|
        cardsText[index] = card_as_text(card)
      end

      7.times do |row|
        cardsText.each_with_index do |card, index|
          print "#{add_color(card[(row * 10)..9 + (row * 10)], line[index])}    "
        end
        $stdout.flush
        puts ''
      end

      line.length.times do
        print "    #{'%2d' % i}        "
        i += 1
      end

      $stdout.flush
      puts ''
    end
    nil
  end

  def self.card_as_text(card)
    shape = card_shape(card)
    text = card_top_bottom(card)
    text += card_side(card)
    l1 = card_side(card)
    l2 = card_side(card)
    l3 = card_side(card)
    l2[4..5] = shape if card.number == 1 || card.number == 3
    if card.number == 2 || card.number == 3
      l1[2..3] = shape
      l3[6..7] = shape
    end
    text += l1 + l2 + l3
    text += card_side(card)
    text += card_top_bottom(card)
    text
  end

  def self.card_top_bottom(card)
    if card.shading == :solid
      '██████████'
    elsif card.shading == :striped
      '##########'
    else
      '          '
    end
  end

  def self.card_side(card)
    if card.shading == :solid
      '█        █'
    elsif card.shading == :striped
      '#        #'
    else
      '          '
    end
  end

  def self.card_shape(card)
    if card.shape == :diamond
      '<>'
    elsif card.shape == :squiggle
      '~~'
    else
      '()'
    end
  end

  def self.add_color(text, card)
    if card.color == :red
      text.red
    elsif card.color == :green
      text.green
    else
      text.magenta
    end
  end
end

class String
  def red
    "\e[31m#{self}\e[0m"
  end

  def green
    "\e[32m#{self}\e[0m"
  end

  def magenta
    "\e[35m#{self}\e[0m"
  end

  def bold
    "\e[1m#{self}\e[22m"
  end

  def italic
    "\e[3m#{self}\e[23m"
  end

  def underline
    "\e[4m#{self}\e[24m"
  end
end
