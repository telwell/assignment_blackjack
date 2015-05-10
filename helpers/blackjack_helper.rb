# Setup the BlackjackHelper module. This will help with things like
# initializing play, setting session variables, and other things that
# shouldn't necessarily be done within the various classes.

module BlackjackHelper
	def create_instance_from_session
		@deck = Deck.new(session[:saved_deck])
	  @deck.shuffle_deck if new_game?
	  @dealer = Dealer.new(session[:dealer_shown], @deck)
	  @player = Player.new(session[:player_cards], @deck)
	end

	def start_play
		@player.hit
		@dealer.hit
		@player.hit
		@dealer.hit
	end

	def save_state
		session[:dealer_shown] = @dealer.cards
		session[:player_cards] = @player.cards
		session[:saved_deck] = @deck.deck.to_json
	end

	def new_game?
		session[:saved_deck] ? false : true
	end

	# Get the message for the :stay view which tells us
	# who won.
	def who_won?
		if @dealer.bust?
			message = "Dealer busted. Congrats, you won!"
		elsif @dealer.value_as_int > @player.value_as_int
			message = "Dealer wins. Sorry, try again!"
		elsif @dealer.value_as_int == @player.value_as_int
			message = "PUSH. No one won, keep your bet."
		else
			message = "Congragulations, YOU WON!"
		end
		message
	end
end