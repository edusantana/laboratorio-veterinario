# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

proprietario=User.create(email: 'proprietario@gmail.com', password: 'ruby123')
veterinario=User.create(email: 'veterinario@gmail.com', password: 'ruby123')

lupa = Laboratorio.create(nome: "Laboratório Lupa", subdomain: 'lupa')
citopatologico = ExameTipo.create(laboratorio: lupa, nome: "Citopatológico", campos: "Local da lezão,Descrição da lezão")

