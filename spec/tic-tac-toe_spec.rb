require_relative '../tic-tac-toe.rb'

describe 'board' do

  before :all do
    @game = Board.new
  end

  describe 'piece placement' do
    context 'Before any pieces are placed' do
      it 'should be empty at start' do
        expect(@game.grid).to eq [['empty', 'empty', 'empty'], ['empty', 'empty', 'empty'], ['empty', 'empty', 'empty']]
      end
    end

    context 'After pieces are placed' do
      it 'should include the piece at the corresponding grid coordinate' do
        @game.place_piece(2, 0, 'O')
        @game.place_piece(2, 1, 'O')
        expect(@game.grid).to eq [['empty', 'empty', 'O'], ['empty', 'empty', 'O'], ['empty', 'empty', 'empty']]
      end
    end
  end

  describe 'game over function' do

    context 'when the game is not over' do
      it 'should not be game over' do
        expect(@game.game_over).to be false
      end

      it 'should have ongoing game status' do
        expect(@game.game_status).to eq 'Ongoing'
      end
    end

    context 'when the game is over' do
      it 'should return that the game is over' do
        @game.place_piece(0, 0, 'X')
        @game.place_piece(0, 1, 'X')
        @game.place_piece(0, 2, 'X')
        expect(@game.game_over?).to be true
      end

      it 'should not have ongoing game status' do
        expect(@game.game_status).to_not eq 'Ongoing'
      end
    end
  end
end

describe 'players' do 

  before :all do
    @game = Board.new
    @player = PlayerPair.new(@game)
  end

  it 'should be able to create a player that uses X\'s' do
    @player.x_player = 'X Player'
    expect(@player.x_player).to eq 'X Player'
  end

  it 'should be able to create a player that uses O\'s' do
    @player.o_player = 'O Player'
    expect(@player.o_player).to eq 'O Player'
  end
end