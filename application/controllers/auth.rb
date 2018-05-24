module TalkUp
  # Web App for login (authentication)
  class App < Roda

    route('auth') do |routing|
      routing.on 'login' do
        # GET /auth/login
        routing.get do
          view :login
        end

        # POST /auth/login
        routing.post do
          result =  Account.auth(routing.params)
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
