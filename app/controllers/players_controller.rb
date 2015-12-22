class PlayersController < ApplicationController
  def index
    @players = Player.all.order(wins: :desc)
  end

  def new
    @player = Player.new
  end

  def show
    @player = Player.find(params[:id])
    @history = PlayerHistory.from_player(@player)
  end

  def create
    @player = Player.new(player_params)
    if @player.save
      flash[:success] = "Player \"" + @player.name + "\" created!"
      redirect_to players_path
    else
      render 'new'
    end
  end

  private

  def player_params
    params.require(:player).permit(:name)
  end
end
