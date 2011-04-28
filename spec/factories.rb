Factory.define :user_type do |f|
  f.sequence(:name) { |n| "foo#{n}" }
end

Factory.define :user_want do |f|
  f.sequence(:name) { |n| "foo#{n}" }
end
