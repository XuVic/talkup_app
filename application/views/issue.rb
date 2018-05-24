module TalkUp
    module View

        class Issue
            
            def initialize(issue_info)
                @issue = issue_info
            end

            def title
                @issue.title
            end
            
        end
    end
end