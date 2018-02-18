FactoryBot.define do
  factory :organizacao do
    subdomain
    association :dono, factory: :user
    experimental {false}

    factory :organizacao_experimental do
      experimental {true}
    end

    after(:build) {|org| org.dono.add_role :dono, org}
  end
end
