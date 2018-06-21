require 'dry-monads'

module TalkUp

    module CommentService
        extend Dry::Monads::Either::Mixin

        def self.add_feedback(feedback_data, token)
            result = ApiGateway.new.add_feedback(feedback_data, token)
            if result.code < 300
                Right(result.message)
            else
                Left(result.message)
            end
        end
    end 
end