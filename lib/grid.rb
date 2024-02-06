class Grid

	def self.print_grid(cards)
		# puts add_color(card1[0..9], cards[0])
		# puts add_color(card1[10..19], cards[0])
		# puts add_color(card1[20..29], cards[0])
		# puts add_color(card1[30..39], cards[0])
		# puts add_color(card1[40..49], cards[0])
		# puts add_color(card1[50..59], cards[0])
		# puts add_color(card1[60..69], cards[0])
		# puts '    01    '



		i = 1
		until cards.empty?
			line = cards.shift(6)
			card1 = card_as_text(line[0]) if(line[0])
			card2 = card_as_text(line[1]) if(line[1])
			card3 = card_as_text(line[2]) if(line[2])
			card4 = card_as_text(line[3]) if(line[3])
			card5 = card_as_text(line[4]) if(line[4])
			card6 = card_as_text(line[5]) if(line[5])
			puts "#{add_color(card1[0..9], line[0])}    #{add_color(card2[0..9], line[1])}    #{add_color(card3[0..9], line[2])}    #{add_color(card4[0..9], line[3])}    #{add_color(card5[0..9], line[4])}    #{add_color(card6[0..9], line[5])}"
			puts "#{add_color(card1[10..19], line[0])}    #{add_color(card2[10..19], line[1])}    #{add_color(card3[10..19], line[2])}    #{add_color(card4[10..19], line[3])}    #{add_color(card5[10..19], line[4])}    #{add_color(card6[10..19], line[5])}"
			puts "#{add_color(card1[20..29], line[0])}    #{add_color(card2[20..29], line[1])}    #{add_color(card3[20..29], line[2])}    #{add_color(card4[20..29], line[3])}    #{add_color(card5[20..29], line[4])}    #{add_color(card6[20..29], line[5])}"
			puts "#{add_color(card1[30..39], line[0])}    #{add_color(card2[30..39], line[1])}    #{add_color(card3[30..39], line[2])}    #{add_color(card4[30..39], line[3])}    #{add_color(card5[30..39], line[4])}    #{add_color(card6[30..39], line[5])}"
			puts "#{add_color(card1[40..49], line[0])}    #{add_color(card2[40..49], line[1])}    #{add_color(card3[40..49], line[2])}    #{add_color(card4[40..49], line[3])}    #{add_color(card5[40..49], line[4])}    #{add_color(card6[40..49], line[5])}"
			puts "#{add_color(card1[50..59], line[0])}    #{add_color(card2[50..59], line[1])}    #{add_color(card3[50..59], line[2])}    #{add_color(card4[50..59], line[3])}    #{add_color(card5[50..59], line[4])}    #{add_color(card6[50..59], line[5])}"
			puts "#{add_color(card1[60..69], line[0])}    #{add_color(card2[60..69], line[1])}    #{add_color(card3[60..69], line[2])}    #{add_color(card4[60..69], line[3])}    #{add_color(card5[60..69], line[4])}    #{add_color(card6[60..69], line[5])}"
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
		if card.number == 1 || card.number == 3
			l2[4..5] = shape
		end
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
		line = ""
		if card.shading == :solid
			line = "██████████"
		elsif card.shading == :striped
			line = "##########"
		else
			line = "          "
		end
		line
	end

	def self.card_side(card)
		line = ""
		if card.shading == :solid
			line = "█        █"
		elsif card.shading == :striped
			line = "#        #"
		else
			line = "          "
		end
		line
	end

	def self.card_shape(card)
		shape = ""
		if card.shape == :diamond
			shape = '<>'
		elsif card.shape == :squiggle
			shape = '~~'
		else
			shape = '()'
		end
		shape
	end

	def self.add_color(text, card)
		if card.color == :red
			text = text.red
		elsif card.color == :green
			text = text.green
		else
			text = text.magenta
		end
		text
	end

end

class String
	def red;            "\e[31m#{self}\e[0m" end
	def green;          "\e[32m#{self}\e[0m" end
	def magenta;        "\e[35m#{self}\e[0m" end

	def bold;           "\e[1m#{self}\e[22m" end
	def italic;         "\e[3m#{self}\e[23m" end
	def underline;      "\e[4m#{self}\e[24m" end
end