puts "Clearing data..."
[Application, ShelterStaff, Animal, User, Shelter].each(&:delete_all)

# Keep shelters low so animals cluster heavily within them
shelters = 15.times.map do
  Shelter.create!(
    name:  "#{Faker::Company.name} Shelter",
    city:  Faker::Address.city,
    state: Faker::Address.state_abbr,
    email: Faker::Internet.unique.email
  )
end

# Scaled up users to create plenty of potential adopters and staff
puts "Seeding users..."
users = 2_000.times.map do
  User.create!(
    email: Faker::Internet.unique.email,
    name:  Faker::Name.name,
    phone: Faker::PhoneNumber.phone_number
  )
end

puts "Seeding staff assignments..."
users.first(150).each_with_index do |user, i|
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

# Bumped to 15,000 animals. This easily crosses the threshold where 
# Postgres realizes sequential scanning is too expensive.
puts "Seeding 15,000 animals (this may take a few moments)..."
animals = 15_000.times.map do
  sp = species_breeds.keys.sample
  Animal.create!(
    name:      Faker::Creature::Animal.name.capitalize,
    species:   sp,
    breed:     species_breeds[sp].sample,
    age_years: rand(0..12),
    # Keeps your ~67% unadopted (adopted = false) ratio intact
    adopted:   [true, false, false].sample, 
    shelter:   shelters.sample
  )
end

statuses = ["pending", "pending", "approved", "rejected"]
puts "Seeding applications..."
10_000.times do
  Application.create!(
    user:   users.sample,
    animal: animals.sample,
    status: statuses.sample,
    notes:  Faker::Lorem.sentence(word_count: 10)
  ) rescue nil
end

puts "Done — #{Shelter.count} shelters, #{Animal.count} animals, #{Application.count} applications"