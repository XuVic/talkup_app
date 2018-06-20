module TalkUp

    class App < Roda

        route('register', 'account') do |routing|

            routing.get(String) do |registeration_token|
                account_info = SecureMessage.decrypt(registeration_token)
                account = View::Account.new( AccountRepresenter.new(OpenStruct.new).from_json account_info )
                view :'account/register', locals: { account: account }
            end

            routing.post do 
                routing.params[:config] = App.config
                
                result = Register.new.call( routing.params )
                if result.success?
                    flash[:notice] = result.value
                    routing.redirect '/auth/login'
                else
                    flash[:error] = result.value
                    routing.redirect
                end

            end
            
            routing.get do 
                account = View::Account.new
                view :'account/register', locals: {account: account}
            end


        end
    end
end