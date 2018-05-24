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
          result =  ApiGateway.new.account_auth( routing.params )
          
          if result.code < 300
            SecureSession.new(session).set(:current_account, result.message)
            location = '/'
          else
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
