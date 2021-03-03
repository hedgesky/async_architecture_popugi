FactoryBot.define do
  factory :task do
    description { "MyText" }
    state { 1 }
    assignee_id { "MyString" }
  end
end
