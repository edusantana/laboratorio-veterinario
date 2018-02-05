# Be sure to restart your server when you modify this file.

# Add new inflection rules using the following format. Inflections
# are locale specific, and you may define rules for as many different
# locales as you wish. All of these examples are active by default:
ActiveSupport::Inflector.inflections(:en) do |inflect|
#   inflect.plural /^(ox)$/i, '\1en'
#   inflect.singular /^(ox)en/i, '\1'
#   inflect.irregular 'person', 'people'
#   inflect.uncountable %w( fish sheep )

   inflect.plural 'requisicao', 'requisicoes'
   inflect.singular 'requisicoes', 'requisicao'
   inflect.plural 'imagem', 'imagens'
   inflect.singular 'imagens', 'imagem'

   inflect.singular 'organizacoes', 'organizacao'
   inflect.plural 'organizacao', 'organizacoes'

   inflect.singular 'tutores', 'tutor'
   inflect.plural 'tutor', 'tutores'

   inflect.singular 'familias', 'familia'
   inflect.plural 'familia', 'familias'

end


ActiveSupport::Inflector.inflections('pt') do |inflect|

  inflect.singular 'tutores', 'tutor'
  inflect.plural 'tutor', 'tutores'

  inflect.singular 'familias', 'familia'
  inflect.plural 'familia', 'familias'


end


ActiveSupport::Inflector.inflections('pt-BR') do |inflect|

  inflect.singular 'tutores', 'tutor'
  inflect.plural 'tutor', 'tutores'

  inflect.singular 'familias', 'familia'
  inflect.plural 'familia', 'familias'


end



# These inflection rules are supported but not enabled by default:
# ActiveSupport::Inflector.inflections(:en) do |inflect|
#   inflect.acronym 'RESTful'
# end
