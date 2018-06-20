require 'dry-validation'

module TalkUp

    module Form
        DATE_REGEX = /([0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9])/

        NewIssue = Dry::Validation.Params do
            required(:title).filled
            required(:description).filled
            required(:deadline).filled(format?: DATE_REGEX)
            required(:section).filled 
        end
    end
end