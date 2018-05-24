require 'dry-monads'

module TalkUp

    module Account
        extend Dry::Monads::Either::Mixin

        def self.auth(input)
            result =  ApiGateway.new.account_auth( input )
            if result.code < 300
                Right(result.message)
            else
                Left(result.message)
            end
        end
    end
end