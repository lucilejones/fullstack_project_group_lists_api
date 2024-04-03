# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
(1..5).each do |i|
    user = User.create!(
        username: Faker::Internet.username(specifier: 3..20, separators: %w(_)),
        email: Faker::Internet.email,
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name,
        password: 'password',
        password_confirmation: 'password'
    )

    rand(1..2).times do
        group = user.created_groups.create!(
            name: Faker::Lorem.word
        )
        
        group.members << user

        User.where.not(id: user.id).order('RANDOM()').limit(rand(1..3)).each do |other_user|
            group.members << other_user unless group.members.include?(other_user)
        end
    end

    rand(1..3).times do
        # user.lists.create!(name: Faker::Lorem.word)
        list = List.create!(
            name: Faker::Lorem.word,
            user_id: user.id
        )

        if rand(1..5) <= 4
            group = user.created_groups.sample
            list.group_id = group.id if group.present?
            puts "Adding groups"
        end
      
        list.save

        rand(5..10).times do
            Item.create(
                name: Faker::Lorem.word,
                brand: Faker::Lorem.word,
                store: Faker::Lorem.word,
                notes: Faker::Lorem.paragraph,
                need_to_purchase: Faker::Boolean.boolean,
                list_id: list.id
            )
        end
    end
end

