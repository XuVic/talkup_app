require 'dry-monads'

module TalkUp

    module AccountService
        extend Dry::Monads::Either::Mixin

        def self.collaborators(input)
            result = ApiGateway.new.account_collaborators(input)
            if result.code < 300
                Right(result.message)
            else
                Left("Empty")
            end
        end
    end
end