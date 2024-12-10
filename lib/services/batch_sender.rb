# frozen_string_literal: true

class BatchSender
  def initialize(service:)
    @service = service
  end

  def send_batch(batch)
    json_batch = batch.to_json
    @service.call(json_batch)
  end
end
