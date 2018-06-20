module TalkUp
  # Web App for login (authentication)
  class App < Roda

    route('auth') do |routing|

      def gh_oauth_url(config)
        url = config.GH_OAUTH_URL
        client_id = config.GH_CLIENT_ID
        scope = config.GH_SCOPE

        "#{url}?client_id=#{client_id}&scope=#{scope}"
      end
      routing.on 'github_sso_callback' do
          routing.route('github_sso_callback', 'auth')
      end

      routing.on 'login' do
        # GET /auth/login
        routing.get do
          view :'account/login', locals:{gh_oauth_url: gh_oauth_url(App.config)}
        end

        # POST /auth/login
        routing.post do
          result =  AuthCredentials.new.call(routing.params)
          SecureSession.new(session).set(:current_account, result.value) if result.success?
          if result.success?
            flash[:notice] = 'Welcome~'
            location = '/'
          else
            flash[:error] = result.value
            location = '/auth/login'
          end
          
          routing.redirect location
        end
      end

      routing.on 'logout' do
        # GET /auth/logout
        routing.get do
          SecureSession.new(session).delete(:current_account)
          routing.redirect '/'
        end
      end
    end

  end
end
