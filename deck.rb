# Creating a helper class for the deck.
# I want to be able to shuffle, get next card, 
# and get the value of a card. In order
# for this to be useful on the web the initialize 
# method can take a serialized deck.

class Deck
	attr_reader :deck

	def initialize(saved_deck = nil)
		@deck = (saved_deck.nil? ? create_deck : JSON.parse(saved_deck))
	end

	def create_deck
		quarter_deck = [2,3,4,5,6,7,8,9,10,"J","Q","K","A"]
		final_deck = []
		4.times do
			final_deck << quarter_deck
		end
		final_deck.flatten
	end

	def shuffle_deck
		10.times {@deck = @deck.shuffle}
	end

	def deal_card
		@deck.pop
	end


end