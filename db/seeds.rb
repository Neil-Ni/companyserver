# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)



company = FactoryGirl.create(:company)
user = FactoryGirl.create(:user, company: company)
user_2 = FactoryGirl.create(:user, company: company)
user_3 = FactoryGirl.create(:user, company: company)

team = FactoryGirl.create(:team, company: company)
FactoryGirl.create(:admin, user: user, team: team)

job_1 = FactoryGirl.create(:job, team: team)
job_2 = FactoryGirl.create(:job, team: team)

worker_1 = FactoryGirl.create(:worker, team: team, user: user)
worker_2 = FactoryGirl.create(:worker, team: team, user: user)
