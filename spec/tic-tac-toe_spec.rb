require_relative '../tic-tac-toe.rb'

describe 'board' do

  before :all do
    @game = Board.new
  end

  it 'should be empty' do
    expect(@game.grid).to eq [['empty', 'empty', 'empty'], ['empty', 'empty', 'empty'], ['empty', 'empty', 'empty']]
  end

  it 'should not be game over' do
    expect(@game.game_over).to be false
  end

  it 'should have ongoing game status' do
    expect(@game.game_status).to eq 'Ongoing'
  end
end

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