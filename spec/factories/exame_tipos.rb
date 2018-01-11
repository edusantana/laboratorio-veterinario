FactoryBot.define do
  
  factory :exame_tipo do
    sequence :nome {|n| "Exame tipo #{n}"}
    campos ""
    laboratorio
  end

end
