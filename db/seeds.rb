# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

BodyPart.create(
  [
    {:name => 'Left Arm', :x => 30, :y => 135},
    {:name => 'Right Arm', :x => 205, :y => 133},
    {:name => 'Left Leg', :x => 82, :y => 325},
    {:name => 'Right Leg', :x => 160, :y => 325},
    {:name => 'Waist', :x => 125, :y => 205},
    {:name => 'Chest', :x => 125, :y => 125}
  ]
)

UserType.create(
  [
    {:name => 'A trainer'},
    {:name => 'A health professional'},
    {:name => 'Looking for trainers'},
    {:name => 'Looking for training buddies'},
    {:name => 'Looking for health professionals'}
  ]
)

UserWant.create(
  [
    {:name => 'Lose weight'},
    {:name => 'Gain muscle/mass'},
    {:name => 'Train for sport'},
    {:name => 'Be fit and healthier'},
    {:name => 'Transform my body'},
    {:name => 'Prevent or heal sickness'}
  ]
)
