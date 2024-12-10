# frozen_string_literal: true

require 'rspec'

RSpec.describe BatchSender do
  let(:batch_sender) { described_class.new(service: service) }
  let(:batch) { instance_double(Batch, to_json: 'a_json') }
  let(:service) { ExternalService.new }

  describe '#send_batch' do
    before do
      allow(service).to receive(:call).with('a_json').and_return(true)
    end

    it 'sends a batch of products' do
      batch_sender.send_batch(batch)
      expect(service).to have_received(:call).with('a_json')
    end
  end
end
