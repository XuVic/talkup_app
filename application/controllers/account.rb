module TalkUp
  class App < Roda
    route('account') do |routing|
      routing.on 'register' do
          routing.route('register', 'account')
      end
      
      routing.on do
        # GET /account/[username]
        routing.get String do |username|
          if @current_account.login?
            view :account, locals: { current_account: @current_account }
          else
            routing.redirect '/auth/login'
          end
        end
      end
    end
  end
end
