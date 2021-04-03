class RabbitQueue
  def initialize(name, exchange_name)
    @name = name
    @exchange_name = exchange_name
  end

  def subscribe(&block)
    conn = Bunny.new.tap(&:start)
    channel = conn.create_channel

    queue = channel.queue(@name, durable: true)
    queue.bind(@exchange_name)

    begin
      queue.subscribe(block: false) do |_delivery_info, _properties, body|
        block.call(JSON.parse(body))
      end
    rescue => e
      Rails.logger.warn "Closing queue connection. #{e.class}: #{e.message}"
      channel.close
      conn.close
    end
  end
end
