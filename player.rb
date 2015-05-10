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

	# Return the current value of the hand as a string.
	# Will return something like 10/20 if there is an 
	# ace in the hand.
	def hand_value
		add_card_value(all_sums = [[]])
		convert_aces(all_sums)
		all_sums.map! do |value_set|
			value_set.inject :+
		end
		return_sum(all_sums)
	end

	# Is the current value a bust? If so return true.
	def bust?
		value_as_int > 21 ? true : false
	end

	# Return the current hand value as an integer. If there's
	# an ace involved it will return the lower of the two potential
	# values (i.e. 7/17 returns 7) except in the case of blackjack
	# where this will return 21 (even though it would show 11/21 normally).
	def value_as_int
		unless hand_value.split('/')[1].nil?
			if hand_value.split('/')[1].to_i >= 17 && hand_value.split('/')[1].to_i <= 21
				hand_value.split('/')[1].to_i
			else
				hand_value.split('/')[0].to_i
			end
		else
			hand_value.split('/')[0].to_i
		end
	end

	private

	# Creates a second array for sums then checks if 
	# any of those values are 1 (meaning there's an ace).
	# If so, then convert that value to 11 so we can get the 
	# other value of a hand w/ an ace.
	def convert_aces(all_sums)
		all_sums[1] = Array.new(all_sums[0])
		all_sums[1][all_sums[1].index(1)] = 11 if all_sums[1].any?{|value| value == 1}
	end

	# Checks to see if the first and second sum equal each other.
	# If they do, then there's no ace and we should return the 
	# first value. Otherwise, there is an ace and we should join
	# them with '/' and return that.
	def return_sum(all_sums)
		if all_sums[0] == all_sums[1] || all_sums[1] > 21 
			all_sums[0].to_s 
		else 
			all_sums.join('/')
		end
	end

	# Push the value of a particular card to the 
	# all sums array.
	def add_card_value(all_sums)
		@cards.each do |card|
			if card.is_a? (Fixnum)
				all_sums[0] << card
			elsif is_ace?(card) 
				all_sums[0] << 1
			else
				all_sums[0] << 10
			end
		end
	end

	# Simple helper to see if a card is an ace.
	def is_ace?(card)
		card == "A" ? true : false
	end
end

class Dealer < Player
	attr_reader :cards, :hidden_card

	def initialize(cards, deck)
		super	
	end

	def cards_string
		@cards[0].to_s
	end

	def all_cards
		@cards.join('-')
	end
end