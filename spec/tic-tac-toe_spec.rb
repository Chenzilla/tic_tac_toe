require_relative '../tic-tac-toe.rb'

describe 'players' do 

  before :all do
    @game = Board.new
    @player = PlayerPair.new(@game)
  end

  it 'should be able to create a player using X' do
    @player.x_player = 'X Player'
    expect(@player.x_player).to eq 'X Player'
  end
  
end