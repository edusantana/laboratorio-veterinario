# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

dono=User.create(email: 'dono@gmail.com', password: 'ruby123')
cliente=User.create(email: 'cliente@gmail.com', password: 'ruby123')

lupa = Laboratorio.create(nome: "Laboratório Lupa", subdomain: 'lupa', dono: dono)
citopatologico = ExameTipo.create(laboratorio: lupa, nome: "Citopatológico", campos: "Local da lezão,Descrição da lezão")

ExameRequisicao.create(requisitante: cliente, proprietario: "Patrícia", nome: "Bob", idade: 4, especie: "Cachorro", raca: "Poodle", laboratorio: lupa, tipo: citopatologico)
req = ExameRequisicao.create(requisitante: cliente, proprietario: "Aline", nome: "Magali", idade: 2, especie: "Gato", raca: "persa", laboratorio: lupa, tipo: citopatologico)
req.confirmar_recebimento!