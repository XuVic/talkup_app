module TalkUp

    class App < Roda

        route('register', 'account') do |routing|

            routing.post do 
                result = Register.new.call(routing.params)
                location = response_handler(result, ['/account/login', '/account/register'])
                
                routing.redirect location
            end
            
            routing.get do 
                view :register
            end
        end
    end
end