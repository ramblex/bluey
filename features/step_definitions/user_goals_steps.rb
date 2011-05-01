Given /^I have the default body parts$/ do
  Given "I have the following body_part records:", table(%{
    | name      |
    | Left Arm  |
    | Right Arm |
    | Left Leg  |
    | Right Leg |
    | Chest |
    | Waist |
    | General |})
end

Given /^I am authenticated on the goals tab$/ do
  Given %{I have the default body parts}
  And %{I sign up and sign in with name "foo" and email "user@test.com"}
  And %{I follow "Goals"}
end
