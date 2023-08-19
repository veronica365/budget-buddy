def login_user(user)
  fill_in 'Email', with: user.email
  fill_in 'Password', with: '0000000'
  click_button 'Next'
end
