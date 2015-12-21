class PlayersController < ApplicationController
	def index
		@players = Player.all
	end

	def new
		@player = Player.new
	end

	def show
		@player = Player.find(params[:id])
		@history = PlayerHistory.from_player(@player)
	end

	def create
		@player = Player.create(player_params)
		if @player
			flash[:success] = "Player \"" + @player.name + "\" created!"
			redirect_to players_path
		else
			flash[:error] = "Error creating player!"
			render 'new'
		end
	end

	private

	def player_params
		params.require(:player).permit(:name)
	end
end
