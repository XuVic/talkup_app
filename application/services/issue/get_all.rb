require 'dry-monads'

module TalkUp

    module IssueService
        extend Dry::Monads::Either::Mixin

        def self.get_all(input)
            result = ApiGateway.new.issues_info(input[:section], input[:token])

            if result.code < 300
                Right(result.message)
            else
                Left({:errors => {:issue => ['nothing']}}.to_json)
            end
        end
    end
end