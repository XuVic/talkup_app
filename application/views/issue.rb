module TalkUp
    module View

        class Issue

            LINK = {
                :show => "/issue/",
                :edit => "/issue/edit/",
                :delete => "/issue/delete/",
                :comment => "/comment/"
            }
            
            def initialize(issue_info)
                @issue = issue_info
            end

            def id
                @issue.id
            end

            def section
                @issue.section
            end

            def title
                @issue.title
            end
            
            def deadline
                @issue.deadline.chars[0..9].join()
            end

            def anonymous
                @issue.anonymous == 1 
            end
        
            def description
                @issue.description
            end

            def owner
                @issue.owner.username
            end

            def comments
                @issue.comments.map {|comment| Comment.new(comment) }
            end

            def collaborators
                @issue.collaborators.map {|collaborator| Account.new(collaborator)}
            end

            def link(action)
                LINK[action] + id
            end

            #policy
            def can_view?
                @issue.can_view
            end

            def can_comment?
                @issue.policy.can_comment
            end

            def can_comment_anonymously?
                @issue.policy.can_comment_anonymously
            end

            def can_edit?
                @issue.policy.can_edit
            end

            def can_delete?
                @issue.policy.can_delete
            end

            def can_add_collaborators?
                @issue.policy.can_add_collaborators
            end

            def can_remove_collaborators?
                @issue.policy.can_remove_collaborators
            end

            def can_leave?
                @issue.policy.can_leave
            end
            
        end
    end
end