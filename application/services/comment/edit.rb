require 'dry-monads'

module TalkUp

    module CommentService
        extend Dry::Monads::Either::Mixin

        def self.edit(comment_data, token)
            result = ApiGateway.new.comment_edit(comment_data, token)
            if result.code < 300
                Right(result.message)
            else
                Left(result.message)
            end
        end
    end 
end