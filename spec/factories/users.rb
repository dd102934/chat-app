FactoryBot.define do
 factory :user do
    sequence(:username) { |n| "tester#{n}" }
    password "dottle-nouveau-pavilion-tights-furze"
  end
end
