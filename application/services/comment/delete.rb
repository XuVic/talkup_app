require 'dry-monads'

module TalkUp

    module CommentService
        extend Dry::Monads::Either::Mixin

        def self.delete(comment_data, token)
            result = ApiGateway.new.comment_delete(comment_data, token)
            if result.code < 300
                Right(result.message)
            else
                Left(result.message)
            end
        end
    end 
end