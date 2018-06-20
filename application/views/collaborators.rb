module TalkUp
    module View

        class Collaborators
            
            def initialize(collaborators_info=nil)
                @collaborators = collaborators_info
            end

            def username
                @collaborators.collaborators.map {|c| c.username}
            end

        end
    end
end