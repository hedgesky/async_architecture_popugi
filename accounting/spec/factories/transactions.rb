FactoryBot.define do
  factory :transaction do
    balance_id { "MyString" }
    amount { 1 }
    type { "" }
    description { "MyText" }
  end
end
