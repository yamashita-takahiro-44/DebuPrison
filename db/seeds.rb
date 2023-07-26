# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

ExerciseType.create(name: "ウォーキングなどの軽運動", calories_per_minute: 3)
ExerciseType.create(name: "ジョギングなどの中等度運動", calories_per_minute: 6)
ExerciseType.create(name: "HIITや全力走などの重運動", calories_per_minute: 10)
