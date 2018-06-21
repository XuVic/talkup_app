module TalkUp

    class App < Roda

        route('collaborators', 'issue') do |routing|

            routing.on 'delete' do 
                routing.post do 
                    input = routing.params
                    input[:token] = @current_account.token
                    result = IssueService.remove_collaborator(input)
                    result.value
                end
            end
            
            routing.post do
                input = routing.params
                input[:token] = @current_account.token
                result = IssueService.add_collaborators(input)
                result.value
            end

        end
    end
end