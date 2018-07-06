module Features
  module SessionHelpers
    def sign_up_with(email, password)
      customer = attributes_for(:customer)
      visit new_customer_session_path
      fill_in 'Email', with: email || customer.email
      fill_in 'Password', with: password || customer.password
      fill_in 'Confirm Password', with: password || customer.password
      submit_form
    end

    def sign_in_as_user
      customer = create(:customer)
      visit new_customer_session_path
      fill_in 'Email', with: customer.email
      fill_in 'Password', with: customer.password
      submit_form
    end
  end
end
