FactoryBot.define do
  factory :task_assignment do
    task_id { "MyString" }
    cost { 1 }
    task_description { "MyText" }
    account_id { "MyString" }
  end
end
