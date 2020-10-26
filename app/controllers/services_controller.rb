class ServicesController < ApplicationController

  def create
    service_route = params[:service] || 'no service (invalid callback)'

    omniauth = request.env['omniauth.auth']

    if omniauth && params[:service]
      if service_route == 'facebook'
        email = omniauth['extra']['raw_info']['email'] || ''
        name = omniauth['extra']['raw_info']['name'] || ''
        uid = omniauth['extra']['raw_info']['id'] || ''
        provider = 'Facebook' || ''
      elsif service_route == 'google_oauth2'
        email = omniauth['info']['email'] || ''
        name = omniauth['info']['name'] || ''
        uid = omniauth['uid'] || ''
        provider = 'Google' || ''
      end
      if (uid != '') && (provider != '')
        if !logged_in?
          auth = Service.find_by_provider_and_uid(provider, uid)
          if auth
            flash[:success] = t('services.create.sign_in.success_log_in', provider: provider.capitalize)
            user = User.find_by_email(auth.uemail)
            log_in(user)
            redirect_to root_url
          else
            if email != ''
              existinguser = User.find_by_email(email)
              if existinguser
                existinguser.services.create(provider: provider, uid: uid, uname: name, uemail: email)
                existinguser.activated = true
                flash[:success] = t('services.create.sign_in.success_with_link_to_email', provider: provider.capitalize, email: existinguser.email)
                existinguser.save
                log_in(existinguser)
                redirect_to root_url
              else
                password = SecureRandom.hex(10)
                user = User.new(email: email, password: password, password_confirmation: password,name: name, activated: true, activated_at: Time.zone.now)
                user.services.build(provider: provider, uid: uid, uname: name, uemail: email)
                user.save
                flash[:success] = t('services.create.sign_up.success_create', provider: provider.capitalize)
                log_in(user)
                redirect_to root_url
              end
            else
              flash[:error] = t('services.create.sign_in.error_used_on_site', provider: provider.capitalize)
              redirect_to new_user_url
            end
          end
        else
          auth = Service.find_by_provider_and_uid(provider, uid)
          if !auth
            current_user.services.create(provider: provider, uid: uid, uname: name, uemail: email)
            flash[:info] = t('services.create.sign_in.info_add_to_account', provider: provider.capitalize)
            redirect_to root_url
          else
            flash[:info] = t('services.create.sign_in.info_allready_add', provider: provider.capitalize)
            redirect_to root_url
          end
        end
      else
        flash[:error] = t('services.create.sign_in.error_invalid_data', service_route: service_route.capitalize)
        redirect_to root_url
      end
    else
      flash[:error] = t('services.create.sign_in.error_auth', service_route: service_route.capitalize)
      redirect_to root_url
    end
  end

  def destroy
    Service.find(params[:id]).destroy
    flash[:success] = t('services.destroy.success')
    redirect_to users_url
  end

end
