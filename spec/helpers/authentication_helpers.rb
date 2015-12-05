module AuthenticationHelpers
  def sign_in_as(user)
    visit login_path
    fill_in('session[username]', with: user.username)
    fill_in('session[password]', with: user.password)
    within('main') do
      click_button('Sign in')
    end
  end

  def controller_sign_in_as(user)
    request.session[:user_id] = user.id
  end
end

RSpec.configure do |c|
  c.include AuthenticationHelpers 
end
