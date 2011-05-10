Factory.define :user_type do |f|
  f.sequence(:name) { |n| "foo#{n}" }
end

Factory.define :user_want do |f|
  f.sequence(:name) { |n| "foo#{n}" }
end

Factory.define :user_image do |f|
  f.name "foo"
  f.picture_file_name "foo.png"
  f.user_profile_id 1
end

Factory.define :body_part do |f|
  f.name "foo"
end

Factory.define :exercise do |f|
  f.name "Exercise"
end

Factory.define :plan do |f|
  f.name "Plan name"
  f.description "Plan description"
end

Factory.define :plan_item do |f|
end

Factory.define :user do |user|
  user.email "test@test.com"
  user.password "password"
end

Factory.define :user_profile do |f|
  f.name "My name"
end
