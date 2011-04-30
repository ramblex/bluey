Given /^I am authenticated on the symptoms tab$/ do
  Given %{I sign up and sign in with name "foo" and email "user@test.com"}
  And %{I follow "Symptoms"}
end
