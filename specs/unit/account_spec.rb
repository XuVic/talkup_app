require_relative '../spec_helper.rb'

describe 'Test Account Unit' do 

    describe 'Test Account Register' do 

        it 'BAD: It should be able to render error message' do 
            data = DATA[:accounts][3]
            data[:confirmed_pwd] = 'error'
            result = TalkUp::Register.new.call(data)

            _(result.success?).must_equal false
            _(result.value).must_be_kind_of String
        end
    end

    describe 'Test Collaborators Getting' do 

        it 'HAPPY: It should be able to get collaborators' do 
            result = TalkUp::AccountService.collaborators(DATA[:accounts][0][:token])
            collaborators = TalkUp::CollaboratorsRepresenter.new(OpenStruct.new).from_json result.value
            collaborators_view = TalkUp::View::Collaborators.new(collaborators)

            _(result.success?).must_equal true
            _(collaborators_view.username).wont_be_empty
        end
    end

    describe 'Test SSO Authenticate' do 

        it 'HAPPY: it should be able to return account msg' do 
            
        end
    end

end