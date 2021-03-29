class RabbitQueue
  def initialize(name)
    @name = name
  end

  def push(payload)
    with_queue do |queue|
      queue.publish(payload.to_json)
    end
  end

  def pop
    with_queue do |queue|
      _, _, payload = queue.pop
      JSON.parse(payload) if payload
    end
  end

  private

  attr_reader :name

  def with_queue
    conn = Bunny.new
    conn.start

    queue = conn.create_channel.queue(name)
    result = yield(queue)
    conn.stop

    result
  end
end
