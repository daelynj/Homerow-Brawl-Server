RSpec.describe Websocket::Interactor::ClientCreationUpdate do
  let(:client_1) do
    Websocket::Client.new(connection: double('connection').as_null_object)
  end
  let(:client_2) do
    Websocket::Client.new(connection: double('connection').as_null_object)
  end
  let(:clients) { [client_1, client_2] }

  describe '#client_creation' do
    subject { described_class.new.call(client: client_2) }

    before do
      allow(client_2.player).to receive(:id).and_return(2)
      allow(client_2.player).to receive(:token).and_return('string')
    end

    it 'calls the write method for the given client' do
      expect(client_2.connection).to receive(:write)
      subject
    end
  end
end
