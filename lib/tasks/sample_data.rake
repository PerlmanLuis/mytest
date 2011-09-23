require 'faker'

namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    User.create!( :name => "Perlman Luis",
                  :email => "luisweigh@gmail.com",
                  :password => "880826lushengwei",
                  :password_confirmation => "880826lushengwei")
    99.times do |n|
      name = Faker::Name.name
      email = "example-#{n+1}@railstutorial.org"
      password = "password"
      User.create!( :name => name,
                  :email => email,
                  :password => password,
                  :password_confirmation => password)
    end
  end
  
end
