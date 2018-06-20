require_relative './account_representer.rb'
require_relative './comment_representer.rb'
require_relative './policies/issue_policy_representer.rb'


module TalkUp

    class IssueRepresenter < Roar::Decorator
        include Roar::JSON

        property :id
        property :title
        property :description
        property :deadline
        property :anonymous
        property :process
        property :section
        property :policy, extend: IssuePolicyRepresenter, class: OpenStruct 
        property :owner, extend: AccountRepresenter, class: OpenStruct do
            property :username
        end
        collection :collaborators, extend: AccountRepresenter, class: OpenStruct do
            property :username
        end
        collection :comments, extend: CommentRepresenter, class: OpenStruct
    end
end