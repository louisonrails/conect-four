require_relative '../lib/player'

RSpec.describe Player do
  it 'has a name and a symbol' do
    player = Player.new('Dio', 'X')

    expect(player.name).to eq('Dio')
    expect(player.symbol).to eq('X')
  end
end