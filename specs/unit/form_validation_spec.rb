require_relative '../spec_helper.rb'

describe 'Test Form Validation' do 

    describe 'Auth Form Validation' do 

        it 'HAPPY: It should be successful' do 
            login_info = {'username' => 'Vic', 'password' => 'mypassword'}
            credentials = TalkUp::Form::LoginCredentials.call(login_info)
            _(credentials.success?).must_equal true
        end
    end

    describe 'Registration Form Validation' do 

        it 'HAPPY: It should be successful with register info' do 
            register_info = {'username' => 'Vic', 'email' => 'test@example.com'}
            credentials = TalkUp::Form::Registration.call(register_info)
            _(credentials.success?).must_equal true
        end

        it 'HAPPY: It should be successful with password' do 
            password_info = {password: 'mypassword', confirmed_pwd: 'mypassword', config: 'test'}
            credentials = TalkUp::Form::Passwords.call(password_info)
            _(credentials.success?).must_equal true
        end

    end

    describe 'Issue Form Validation' do 
        
        it 'HAPPY: It should be successful with register info' do 
            register_info = {'title' => 'test', 'description' => 'test', 'section' => 1, 'deadline' => '2016-06-12'}
            credentials = TalkUp::Form::NewIssue.call(register_info)
            _(credentials.success?).must_equal true
        end
        
    end
end