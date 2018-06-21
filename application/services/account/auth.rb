require 'dry-monads'
require 'dry-transaction'

module TalkUp

    class AuthCredentials
        include Dry::Transaction

        step :form_validation
        step :auth_account

        def form_validation(input)
            credentials = Form::LoginCredentials.call(input)
            if credentials.success?
                Right(input)
            else
                error = credentials.errors.map do |k,v|
                    "#{k} #{v.join(',')}"
                end.join(', ')
                Left(error)
            end
        end

        def auth_account(input)
            signed_auth = SecureMessage.sign(input)
            result =  ApiGateway.new.account_auth(signed_auth)
            if result.code < 300
                Right(result.message)
            else
                Left("Invalid Credentials.")
            end
        end

    end
end