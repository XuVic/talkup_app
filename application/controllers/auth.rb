module TalkUp
  # Web App for login (authentication)
  class App < Roda

    route('auth') do |routing|
      routing.on 'login' do
        # GET /auth/login
        routing.get do
          view :'account/login'
        end

        # POST /auth/login
        routing.post do
          result =  AccountService.auth(routing.params)
          SecureSession.new(session).set(:current_account, result.value)
          location = response_handler(result, ['/', '/auth/login'])

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
