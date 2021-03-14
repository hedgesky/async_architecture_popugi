FactoryBot.define do
  factory :task do
    description { "MyText" }
    state { :open }
  end
end
