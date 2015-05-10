# Setup the BlackjackHelper module. This will help with things like
# initializing play, setting session variables, and other things that
# shouldn't necessarily be done within the various classes.

module BlackjackHelper
	def start_play
		@dealer.deal_hidden_card
		@player.hit
		@dealer.hit
		@player.hit
	end

	def save_state
		session[:dealer_hidden] = @dealer.hidden_card
		session[:dealer_shown] = @dealer.cards
		session[:player_cards] = @player.cards
		session[:saved_deck] = @deck.deck.to_json
	end

	def new_game?
		return (session[:saved_deck] ? false : true)
	end
end