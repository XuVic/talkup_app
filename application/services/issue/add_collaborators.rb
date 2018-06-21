require 'dry-monads'

module TalkUp

    module IssueService
        extend Dry::Monads::Either::Mixin

        def self.add_collaborators(input)
            puts input
            result = ApiGateway.new.add_collaborators(input['issue_id'], input['collaborators'] ,input[:token])

            if result.code < 300
                Right(result.message)
            else
                Left(result.message)
            end
        end
    end
end