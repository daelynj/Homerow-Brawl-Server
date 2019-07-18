require 'spec_helper'

RSpec.describe Websocket::Room do
  let(:client) do
    Websocket::Client.new(connection: double('connection').as_null_object)
  end
  let(:room) { described_class.new(id: 1) }

  describe '#add_client' do
    before { room.add_client(client: client) }

    it 'adds the client to the rooms client list' do
      expect(room.clients.length).to eq(1)
    end

    it 'sets the clients ID to the rooms ID' do
      expect(client.room_id).to eq(1)
    end
  end
end
