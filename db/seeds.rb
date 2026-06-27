puts "Clearing data..."
[Application, ShelterStaff, Animal, User, Shelter].each(&:delete_all)

shelters = 10.times.map do
  Shelter.create!(
    name:  "#{Faker::Company.name} Shelter",
    city:  Faker::Address.city,
    state: Faker::Address.state_abbr,
    email: Faker::Internet.unique.email
  )
end

users = 100.times.map do
  User.create!(
    email: Faker::Internet.unique.email,
    name:  Faker::Name.name,
    phone: Faker::PhoneNumber.phone_number
  )
end

users.first(20).each_with_index do |user, i|
  ShelterStaff.create!(
    shelter: shelters[i % shelters.size],
    user:    user,
    role:    ["manager", "volunteer", "vet"].sample
  )
end

species_breeds = {
  "dog"    => ["Labrador", "Poodle", "Beagle", "Bulldog"],
  "cat"    => ["Siamese", "Persian", "Maine Coon", "Tabby"],
  "rabbit" => ["Holland Lop", "Lionhead", "Rex"]
}
animals = 500.times.map do
  sp = species_breeds.keys.sample
  Animal.create!(
    name:      Faker::Creature::Animal.name.capitalize,
    species:   sp,
    breed:     species_breeds[sp].sample,
    age_years: rand(0..12),
    adopted:   [true, false, false].sample,
    shelter:   shelters.sample
  )
end

statuses = ["pending", "pending", "approved", "rejected"]
1_200.times do
  Application.create!(
    user:   users.sample,
    animal: animals.sample,
    status: statuses.sample,
    notes:  Faker::Lorem.sentence(word_count: 10)
  ) rescue nil
end

puts "Done — #{Shelter.count} shelters, #{Animal.count} animals, #{Application.count} applications"