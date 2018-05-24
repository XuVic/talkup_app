require_relative './account_representer.rb'
require_relative './comment_representer.rb'

module TalkUp

    class IssueRepresenter < Roar::Decorator
        include Roar::JSON

        property :id
        property :title
        property :description
        property :deadline
        property :process
        property :section

        property :owner, extend: AccountRepresenter, class: OpenStruct
        collection :collaborators, extend: AccountRepresenter, class: OpenStruct
        collection :comments, extend: CommentRepresenter, class: OpenStruct

    end
end