class OmniauthCallbacksController < Devise::OmniauthCallbacksController

	def facebook
		@user = User.from_omniauth_facebook(request.env["omniauth.auth"])
	    if @user.persisted?
	      flash.notice = "Signed in Through Facebook!"
	     sign_in_and_redirect @user
	    else
	      session["devise.user_attributes"] = @user.attributes
	      flash.notice = "You are almost Done! Please provide a password to finish setting up your account"
	      redirect_to root_url
	    end
	end

	def twitter
        @user = User.from_omniauth_twitter(request.env["omniauth.auth"])
	    if @user.persisted?
	      flash.notice = "Signed in Through twitter!"
	      sign_in_and_redirect @user
	    else
	      session["devise.user_attributes"] = @user.attributes
	      flash.notice = "You are almost Done! Please provide a password to finish setting up your account"
	      redirect_to root_url
	    end
	end

end
