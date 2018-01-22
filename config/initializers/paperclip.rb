Paperclip.interpolates :subdomain do |attachment, style|
  attachment.instance.resultado.requisicao.laboratorio.subdomain
end

Paperclip.interpolates :access_token  do |attachment, style|
  attachment.instance.access_token
end

Paperclip.interpolates :mes  do |attachment, style|
  attachment.instance.resultado.created_at.strftime('%Y-%m')
end

Paperclip.interpolates :resultado_id  do |attachment, style|
  attachment.instance.resultado.id
end