# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

dono=User.create(email: 'dono@mundo.vet', password: 'ruby123')
tecnico=User.create(email: 'tecnico@mundo.vet', password: 'ruby123')
secretario=User.create(email: 'secretario@mundo.vet', password: 'ruby123')
cliente=User.create(email: 'cliente@mundo.vet', password: 'ruby123', nome: 'cliente', cpf: 'cpff', crmv: 'crmv-pb', telefone: '999', endereco: 'meu endereco')

org = Organizacao.create(subdomain: 'lupa', dono: dono)

# Laboratório
lupa = Laboratorio.create(nome: "Laboratório Lupa", apresentacao: 'Laboratório criado para servir a grande João Pessoa.', organizacao: org)
unidade = Unidade.create(nome: "Mangabeira", laboratorio: lupa, endereco: "Rua do garrafão, N 145", telefone: "(83) 3535-1967")
dono.add_role(:dono, org)
tecnico.add_role(:tecnico, org)
secretario.add_role(:secretario, org)
citopatologico = ExameTipo.create(laboratorio: lupa, nome: "Citopatológico", campos: "Local da lezão,Descrição da lezão")
ExameTipo.create(nome: 'Raspado cutâneo', laboratorio: lupa, campos: "Local da lezão,Descrição da lezão")
ExameTipo.create(nome: 'Tricograma', laboratorio: lupa)
ExameTipo.create(nome: 'Pesquisa de Mycoplasma felis', laboratorio: lupa)
ExameTipo.create(nome: 'Urinálise', laboratorio: lupa)
ExameTipo.create(nome: 'Parasitológico de fezes', laboratorio: lupa)
ExameTipo.create(nome: 'Brucelose cnina (AAT)', laboratorio: lupa)
ExameTipo.create(nome: 'Laminocultivo para Dermatófitos', laboratorio: lupa)
ExameTipo.create(nome: 'Brucelose Bovina (AAT)', laboratorio: lupa)
ExameTipo.create(nome: 'Tuberculose Bovina simples', laboratorio: lupa)
ExameTipo.create(nome: 'Histopatológico', laboratorio: lupa)

# Exames
10.times {ExameRequisicao.create(requisitante: cliente, proprietario: "Patrícia", nome: "Bob", idade: 4, especie: "Cachorro", raca: "Poodle", laboratorio: lupa, tipo: citopatologico)}
req = ExameRequisicao.create(requisitante: cliente, proprietario: "Aline", nome: "Magali", idade: 2, especie: "Gato", raca: "persa", laboratorio: lupa, tipo: citopatologico)
req.confirmar_recebimento!

