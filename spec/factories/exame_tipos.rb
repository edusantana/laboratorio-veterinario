FactoryBot.define do
  
  factory :exame_tipo do
    sequence :nome {|n| "Exame tipo #{n}"}
    campos ""
    valor { rand(10..200)  }
    laboratorio
  end

end
