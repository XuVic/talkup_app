
module TalkUp

    class FeedbackRepresenter < Roar::Decorator
        include Roar::JSON

        property :description
        property :commenter , extend: AccountRepresenter, class: OpenStruct
    end
end