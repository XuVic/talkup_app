require 'dry-monads'
require 'dry-transaction'

module TalkUp

    class IssueEdit
        include Dry::Transaction

        step :form_validation
        step :update_issue

        def form_validation(input)
            input = JsonRequestBody.parse_sym(input.to_json)
            validation = Form::NewIssue.call(input[:issue_data])
            if validation.success?
                Right(input)
            else
                error = validation.errors.map do |k,v|
                    "#{k} #{v.join(',')}"
                end.join(', ')
                Left(error)
            end
        end

        def update_issue(input)
            result = ApiGateway.new.issue_update(input[:issue_id], input[:issue_data], input[:token])
            if result.code < 300
                Right(result.message)
            else
                Left(result.message)
            end
        end
    end 
end