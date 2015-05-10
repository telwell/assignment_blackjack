# Required Gems
require 'sinatra'
require 'erb'
require 'pry-byebug'
require 'colorize'
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
  @deck = Deck.new(session[:saved_deck])
  @deck.shuffle_deck if new_game?
  @dealer = Dealer.new(session[:dealer_shown], session[:dealer_hidden], @deck)
  @player = Player.new(session[:player_cards], @deck)
  start_play if new_game?
  save_state
  erb :home
end

get '/new_game' do
	session.clear
	redirect to('/')
end