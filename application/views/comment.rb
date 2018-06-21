module TalkUp

    module View

        class Comment
            
            def initialize(comment_info)
                @comment = comment_info
            end

            def id
                @comment.id
            end
        
            def content
                @comment.content
            end

            def commenter
                @comment.commenter.username
            end

            def can_edit?
                @comment.policy.can_edit
            end

            def can_delete?
                @comment.policy.can_delete
            end

        end
    end
end