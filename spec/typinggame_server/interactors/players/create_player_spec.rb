require 'spec_helper'

describe Interactors::Players::CreatePlayer do
  let(:repository) { PlayerRepository.new }
  let(:interactor) { described_class.new(repository: repository) }
end
