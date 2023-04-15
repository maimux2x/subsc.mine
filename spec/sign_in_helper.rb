# frozen_string_literal: true

module SignInHelper
  def sign_in_as(user)
    OmniAuth.config.test_mode = true
    OmniAuth.config.add_mock(
      user.provider,
      uid: user.uid
    )
    visit root_path
    click_on "Googleアカウントでログイン"
    @current_user = user
  end

  def current_user
    @current_user
  end
end
