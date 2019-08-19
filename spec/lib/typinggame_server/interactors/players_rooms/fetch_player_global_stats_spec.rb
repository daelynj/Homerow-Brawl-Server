require 'spec_helper'

RSpec.describe Interactors::PlayersRooms::FetchPlayerGlobalStats do
  let(:player_attributes) { { 'id' => 1, 'name' => 'octane' } }
  let(:team) { { 'id' => 'X0klA3' } }
  let(:access_token) { 'fdgdfg908g9n9gf09fgh8' }
  let(:player) do
    Interactors::Players::CreatePlayer.new.call(
      player_attributes: player_attributes,
      team: team,
      access_token: access_token
    )
      .player
  end
  let(:room) { Interactors::Rooms::CreateRoom.new.call.room }
  let(:repository) { PlayerRoomRepository.new }

  describe '#call' do
    subject do
      described_class.new(repository: repository).call(uuid: player.uuid)
    end

    before do
      repository.create(
        player_id: player.id,
        room_id: room.id,
        words_typed: 5,
        time: 6,
        mistakes: 2,
        letters_typed: 15,
        position: 100
      )
    end

    context 'when the player and room exist' do
      it 'succeeds' do
        expect(subject.successful?).to be(true)
      end

      it 'exposes the players stats' do
        expect(subject.player_stats[:stats]).to eq(
          {
            average_accuracy: 86.7,
            average_letters_typed: 15,
            average_mistakes: 2,
            average_words_typed: 5,
            average_wpm: 30,
            total_letters_typed: 15,
            total_mistakes: 2,
            total_words_typed: 5
          }
        )
      end
    end
  end
end
