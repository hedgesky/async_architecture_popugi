require 'rails_helper'

RSpec.describe "Balances", type: :request do

  describe "GET /show" do
    it "returns http success" do
      get "/balances/show"
      expect(response).to have_http_status(:success)
    end
  end

end
