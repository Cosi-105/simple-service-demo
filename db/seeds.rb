require 'faker'

1..100.times {
  Fortune.create(fortune: Faker::Hacker.say_something_smart)
}
