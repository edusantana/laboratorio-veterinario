# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

dono=User.create(email: 'dono@gmail.com', password: 'ruby123')
tecnico=User.create(email: 'tecnico@gmail.com', password: 'ruby123')
secretario=User.create(email: 'secretario@gmail.com', password: 'ruby123')
cliente=User.create(email: 'cliente@gmail.com', password: 'ruby123')

# Laboratório
lupa = Laboratorio.create(nome: "Laboratório Lupa", subdomain: 'lupa', dono: dono, apresentacao: 'Laboratório criado para servir a grande João Pessoa.')
dono.add_role(:dono, lupa)
tecnico.add_role(:tecnico, lupa)
secretario.add_role(:secretario, lupa)
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
ExameRequisicao.create(requisitante: cliente, proprietario: "Patrícia", nome: "Bob", idade: 4, especie: "Cachorro", raca: "Poodle", laboratorio: lupa, tipo: citopatologico)
req = ExameRequisicao.create(requisitante: cliente, proprietario: "Aline", nome: "Magali", idade: 2, especie: "Gato", raca: "persa", laboratorio: lupa, tipo: citopatologico)
req.confirmar_recebimento!

