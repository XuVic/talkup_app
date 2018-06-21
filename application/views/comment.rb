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

            def can_feedback?
                @comment.policy.can_feedback
            end


            def feedbacks
                {   like: @comment.feedbacks.select{|f| f.description == 'like'}.length,
                    confusing: @comment.feedbacks.select{|f| f.description == 'confusing'}.length,
                    dislike: @comment.feedbacks.select{|f| f.description == 'dislike'}.length,
                    interesting: @comment.feedbacks.select{|f| f.description == 'interesting'}.length
                }
            end


        end
    end
end