require_relative './issue_representer.rb'

module TalkUp

    class IssuesRepresenter < Roar::Decorator
        include Roar::JSON

        collection :issues, extend: IssueRepresenter , class: OpenStruct do 
            property :id
            property :title
            #property :description
            property :deadline
            property :process
            property :section

            property :owner, extend: AccountRepresenter, class: OpenStruct
        end
    end
end