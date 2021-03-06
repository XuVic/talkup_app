require_relative './account_representer.rb'
require_relative './feedback_representer.rb'
require_relative './policies/comment_policy_representer.rb'

module TalkUp

    class CommentRepresenter < Roar::Decorator
        include Roar::JSON

        property :id
        property :content 
        property :commenter , extend: AccountRepresenter, class: OpenStruct do 
            property :username
        end
        property :policy, extend: CommentPolicyRepresenter, class: OpenStruct
        collection :feedbacks, extend: FeedbackRepresenter, class: OpenStruct
    end
end