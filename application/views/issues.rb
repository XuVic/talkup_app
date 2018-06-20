require_relative './issue.rb'

module TalkUp
    module View

        class Issues
            
            def initialize(issues_info, section)
                @issues = issues_info
                @section = section
            end

            def each_issues
                @issues.issues.map {|issue| Issue.new(issue)}
            end

            def empty?
                @issues.issues.nil?
            end

            def section
                @section
            end

            def section_name
                if section == '1'
                    return 'A'
                else
                    return 'B'
                end
            end
            
        end
    end
end