class RabbitExchange
  def initialize(name)
    @exchange ||= Bunny.new.tap(&:start).create_channel.fanout(name)
  end

  def publish(payload)
    @exchange.publish(payload.to_json)
  end
end