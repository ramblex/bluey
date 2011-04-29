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
