class EventProducer
  def self.account_created(account)
    send_message(
      type: 'account_created', account: to_attrs(account)
    )
  end

  def self.account_updated(account)
    send_message(
      type: 'account_updated', account: to_attrs(account)
    )
  end

  def self.account_deleted(account)
    send_message(
      type: 'account_deleted', account: to_attrs(account)
    )
  end

  class << self
    private

    def queue
      @queue ||= connect_to_queue
    end

    def to_attrs(account)
      account.attributes.slice('id', 'email')
    end

    def send_message(payload)
      queue.publish(payload.to_json)
    end

    def connect_to_queue
      conn = Bunny.new
      conn.start

      # haven't used RabbitMQ yet, and don't know all its features. But it's 11pm, so
      # I don't have time to learn them. So for now, declare single queue, go against
      # best practices and include both producer and consumer names to it.
      #
      # we'll leave handling connections, but that's fine for now
      conn.create_channel.queue('auth-tasks')
    end
  end
end
