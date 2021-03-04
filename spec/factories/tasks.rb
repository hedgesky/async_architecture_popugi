FactoryBot.define do
  factory :task do
    description { "MyText" }
    state { :open }
    assignee_id { "MyString" }
  end
end
