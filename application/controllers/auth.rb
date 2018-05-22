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
          account =  ApiGateway.new.account_auth( routing.params['username'],
                                                  routing.params['password'] )
          #session[:current_account] = account
          SecureSession.new(session).set(:current_account, account.message)
          # flash[:notice] = "Welcome to TalkUp, #{login_input['username']}!"
          routing.redirect '/'
        rescue StandardError
          # flash[:error] = 'Username and Password did not match our records'
          routing.redirect '/auth/login'
        end
      end

      routing.on 'logout' do
        # GET /auth/logout
        routing.get do
          session[:current_account] = nil
          routing.redirect '/auth/login'
        end
      end
    end

  end
end
