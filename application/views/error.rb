module TalkUp
    module Views

        class Error

            def initialize(error)
                @error = error
            end

            def type
                @error[:errors].keys[0]
            end

            def msg
                @error[:errors][type]
            end
        end
    end
end