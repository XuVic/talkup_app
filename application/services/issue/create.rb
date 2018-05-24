require 'dry-monads'

module TalkUp

    module IssueService
        extend Dry::Monads::Either::Mixin

        def self.create(issue_data)
            result = ApiGateway.new.issue_create(issue_data)
            if result.code < 300
                Right(result.message)
            else
                Left(result.message)
            end
        end
    end 
end