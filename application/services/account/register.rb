require 'dry-monads'
require 'dry/transaction'

module TalkUp

    class Register
        include Dry::Transaction
        
        step :password_confirmed
        step :pass_info

        def password_confirmed(input)
            if input['password'] == input['confirmed_pwd']
                input.delete('confirmed_pwd')
                Right(input)
            else
                Left({:errors => {:account => ['password not matched']}}.to_json)
            end
        end
        def pass_info(input)
            result = ApiGateway.new.account_create(input)
            if result.code < 300
                Right(result)
            else
                Left(result.message)
            end
        end

    end
end