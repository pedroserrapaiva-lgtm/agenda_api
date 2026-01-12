require 'faker'

puts "Gerando contatos falsos..."

# cria usuario de teste (ou pega o primeiro)
user = User.first || User.create!(
  email: "teste@example.com",
  password: "123456"
)

10.times do
  Contact.create!(
    name: Faker::Name.name,
    email: Faker::Internet.unique.email,
    phone: Faker::PhoneNumber.cell_phone_in_e164,
    user: user
  )
end

puts "Concluído!"
