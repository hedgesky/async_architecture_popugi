require 'rails_helper'

RSpec.describe "accounts/index", type: :view do
  before(:each) do
    assign(:accounts, [
      Account.create!(
        email: "Email",
        role: "Role"
      ),
      Account.create!(
        email: "Email",
        role: "Role"
      )
    ])
  end

  it "renders a list of accounts" do
    render
    assert_select "tr>td", text: "Email".to_s, count: 2
    assert_select "tr>td", text: "Role".to_s, count: 2
  end
end
