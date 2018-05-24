require_relative '../spec_helper.rb'

describe 'Test Account Unit' do 

    describe 'Test Account Register' do 

        it 'BAD: It should be able to render error message' do 
            data = DATA[:accounts][3]
            data[:confirmed_pwd] = 'error'
            result = TalkUp::Register.new.call(data)
            info = JsonRequestBody.parse_sym result.value
            error = TalkUp::View::Error.new(info)

            _(result.success?).must_equal false
            _(error.type).must_equal :account
        end
    end

end