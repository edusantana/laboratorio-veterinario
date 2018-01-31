FactoryBot.define do
  factory :organizacao do
    subdomain
    association :dono, factory: :user

    after(:build) {|org| org.dono.add_role :dono, org}
  end
end
