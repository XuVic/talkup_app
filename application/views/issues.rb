require_relative './issue.rb'

module TalkUp
    module View

        class Issues
            
            def initialize(issues_info)
                @issues = issues_info
            end

            def each_issues
                @issues.issues.map {|issue| Issue.new(issue)}
            end
            
        end
    end
end