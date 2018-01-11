FactoryBot.define do
  
  sequence :email do |n|
    "person#{n}@example.com"
  end


  factory :user, aliases: [:veterinario, :requisitante] do
    email { generate(:email) }
    password "ruby123"
  end

end
