module Features
  module SessionHelpers
    def set_user_session(user)
      session[:user_id] = user.id
    end

    def sign_in(user)
      visit root_path
      click_link 'Login'
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_button 'Login'
    end    
  end
end