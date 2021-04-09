FactoryBot.define do
  factory :closed_task do
    task_id { "MyString" }
    description { "MyText" }
    assignee_id { "MyString" }
    completion_cost { 1 }
    date { "2021-04-04" }
  end
end
