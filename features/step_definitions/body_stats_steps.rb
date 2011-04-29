Given /^I am authenticated on the body stats tab$/ do
  Given "I have the following body_part records:", table(%{
    | name      |
    | Left Arm  |
    | Right Arm |
    | Left Leg  |
    | Right Leg |
    | Chest |
    | Waist |})
  And %{I sign up and sign in with name "foo" and email "user@test.com"}
  And %{I follow "Body Stats"}
end
