class ServicesController < ApplicationController
  def index; end

  def create
    service_route = params[:service] || 'no service (invalid callback)'

    omniauth = request.env['omniauth.auth']

    if omniauth && params[:service]
      if service_route == 'facebook'
        email = omniauth['extra']['raw_info']['email'] || ''
        name = omniauth['extra']['raw_info']['name'] || ''
        uid = omniauth['extra']['raw_info']['id'] || ''
        provider = omniauth['provider'] || ''
      else
        return
      end

      if (uid != '') && (provider != '')
        if !user_signed_in?
          auth = Service.find_by_provider_and_uid(provider, uid)
          if auth
            flash[:success] = 'Signed in successfully via ' + provider.capitalize + '.'
            user = User.find_by_email(auth.uemail)
            log_in(user)
            redirect_to root_url
          else
            if email != ''
              existinguser = User.find_by_email(email)
              if existinguser
                puts uid, name, email
                existinguser.services.create(provider: provider, uid: uid, uname: name, uemail: email)
                flash[:success] = 'Sign in via ' + provider.capitalize + ' has been added to your account ' + existinguser.email + '. Signed in successfully!'
                existinguser.save
                log_in(existinguser)
                redirect_to root_url
              else
                password = SecureRandom.hex(10)
                user = User.new(email: email, password: password, password_confirmation: password,name: name, activated: true, activated_at: Time.zone.now)
                user.services.build(provider: provider, uid: uid, uname: name, uemail: email)
                user.save
                flash[:success] = 'Your account on CommunityGuides has been created via ' + provider.capitalize + '. In your profile you can change your personal information and add a local password.'
                log_in(user)
                redirect_to root_url
              end
            else
              flash[:error] = service_route.capitalize + ' can not be used to sign-up on CommunityGuides as no valid email address has been provided. Please use another authentication provider or use local sign-up. If you already have an account, please sign-in and add ' + service_route.capitalize + ' from your profile.'
              redirect_to new_user_url
            end
          end
        else
          auth = Service.find_by_provider_and_uid(provider, uid)
          if !auth
            current_user.services.create(provider: provider, uid: uid, uname: name, uemail: email)
            flash[:info] = 'Sign in via ' + provider.capitalize + ' has been added to your account.'
            redirect_to root_url
          else
            flash[:info] = service_route.capitalize + ' is already linked to your account.'
            redirect_to root_url
          end
        end
      else
        flash[:error] = service_route.capitalize + ' returned invalid data for the user id.'
        redirect_to root_url
      end
    else
      flash[:error] = 'Error while authenticating via ' + service_route.capitalize + '.'
      redirect_to root_url
    end
  end

  def destroy; end

end
