# Required Gems
require 'sinatra'
require 'erb'
require 'pry-byebug'
require 'json'

# Require Classes/Helpers
require './deck.rb'
require './player.rb'
require './helpers/blackjack_helper.rb'

# Register Helpers
helpers BlackjackHelper 

# Enable sessions
enable :sessions

# Start making the app

get '/' do
  create_instance_from_session
  start_play if new_game?
  save_state
  erb :home, locals: {player_bust: @player.bust?}
end

get '/new_game' do
	session.clear
	redirect to('/')
end

get '/hit' do
	create_instance_from_session
	@player.hit
	save_state
	erb :home, locals: {player_bust: @player.bust?}
end

get '/stay' do
	create_instance_from_session
	@dealer.hit until @dealer.value_as_int >= 17
	erb :stay, locals: {message: who_won?}
end