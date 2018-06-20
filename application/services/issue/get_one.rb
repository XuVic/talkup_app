require 'dry-monads'

module TalkUp

    module IssueService
        extend Dry::Monads::Either::Mixin

        def self.get_by_id(input)
            result = ApiGateway.new.issue_info(input[:issue_id], input[:token])

            if result.code < 300
                Right(result.message)
            else
                Left({:errors => {:issue => ['nothing']}}.to_json)
            end
        end
    end
end