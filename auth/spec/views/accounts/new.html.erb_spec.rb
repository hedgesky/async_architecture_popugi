require 'rails_helper'

RSpec.describe "accounts/new", type: :view do
  before(:each) do
    assign(:account, Account.new(
      email: "MyString",
      role: "MyString"
    ))
  end

  it "renders new account form" do
    render

    assert_select "form[action=?][method=?]", accounts_path, "post" do

      assert_select "input[name=?]", "account[email]"

      assert_select "input[name=?]", "account[role]"
    end
  end
end
