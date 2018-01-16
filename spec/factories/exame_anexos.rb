FactoryBot.define do
  factory :exame_anexo, aliases: [:anexo] do
    resultado nil
    anexo { File.new("#{Rails.root}/spec/samples/exame_anexos/exame-citopatologico1.pdf") }
  end
end
