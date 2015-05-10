# Creating a main class for a Player (anyone playing against the dealer)
# and the dealer which will be an extension of the Player class.

class Player
	attr_reader :cards

	def initialize(cards, hidden_card = nil, deck)
		@deck = deck
		@cards = cards || []
	end

	def hit
		@cards << @deck.deal_card
	end

	def cards_string
		@cards.join('-')
	end

	def cards_sum
		# Break out into a different method if there's an Ace
		cards_sum_with_ace if cards.any?{|card| card == "A"}
		sum = []
		cards.each do |card|
			if card.is_a? (Fixnum)
				sum << card
			else
				sum << 10
			end
		end
		sum.inject{|sum, el| sum + el}
	end

	# Simple helper to see if a card is an ace.
	def is_ace?(card)
		card == "A" ? true : false
	end
end

class Dealer < Player
	attr_reader :cards, :hidden_card

	def initialize(cards, hidden_card, deck)
		super	
		@hidden_card = hidden_card || []
	end

	def deal_hidden_card
		@hidden_card << @deck.deal_card
	end
end