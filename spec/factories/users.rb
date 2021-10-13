FactoryBot.define do
  factory :user do
    sequence :id do |n|; n; end
    email {"aaa@bbb.com"}
    password_digest {"aaaaaaaaa"}
  end
end
