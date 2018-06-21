require 'dry-monads'

module TalkUp

    module IssueService
        extend Dry::Monads::Either::Mixin

        def self.remove_collaborator(input)
            puts input
            result = ApiGateway.new.remove_collaborator(input['issue_id'], input['collaborator'] ,input[:token])

            if result.code < 300
                Right(result.message)
            else
                Left(result.message)
            end
        end
    end
end