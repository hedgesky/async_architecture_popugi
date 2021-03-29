require 'rails_helper'

RSpec.describe "FinishDays", type: :request do

  describe "GET /create" do
    it "returns http success" do
      get "/finish_day/create"
      expect(response).to have_http_status(:success)
    end
  end

end
