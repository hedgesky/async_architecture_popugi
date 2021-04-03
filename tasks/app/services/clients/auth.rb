module Clients
  class Auth
    def self.account_data(uuid)
      conn = Faraday.new(url: ENV['AUTH_HOST'])
      conn.basic_auth(ENV['AUTH_LOGIN'], ENV['AUTH_PASSWORD'])
      response = conn.get("/api/accounts/#{uuid}")
      OpenStruct.new(JSON.parse(response.body))
    end
  end
end
