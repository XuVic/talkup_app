module TalkUp

    class App < Roda

        route('register', 'account') do |routing|

            routing.post do 
                result = Register.new.call( routing.params )
                location = result.success? ? '/auth/login' : '/account/register'
                
                routing.redirect location
            end
            
            routing.get do 
                view :'account/register'
            end
        end
    end
end