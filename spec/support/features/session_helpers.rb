module Features
  module SessionHelpers
    def set_user_session(user)
      session[:user_id] = user.id
    end

    def sign_in(user)      
      visit new_user_session_path
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_button 'Login'
    end    
  end
end