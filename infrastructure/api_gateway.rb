require 'http'

module TalkUp
  class ApiGateway
    class ApiResponse
      HTTP_STATUS = {
        200 => :ok,
        201 => :created,
        202 => :processing,
        204 => :no_content,

        403 => :forbidden,
        404 => :not_found,
        400 => :bad_request,
        409 => :conflict,
        422 => :cannot_process,

        500 => :internal_error
      }.freeze

      attr_reader :status, :message, :code

      def initialize(code, message)
        @code = code
        @status = HTTP_STATUS[code]
        @message = message
      end

      def ok?
        HTTP_STATUS[@code] == :ok
      end
    end


    def initialize(config = TalkUp::App.config)
      @config = config
    end
    
    #account
    def account_create(account_info_hash)
      call_api(:post, ['accounts'] , account_info_hash, nil)
    end

    def account_info(username)
      call_api(:get, ['accounts', username], nil, nil)
    end

    def account_auth(account_info_hash)
      call_api(:post, ['accounts', 'authenticate', 'email_account'],
                      account_info_hash, nil)
    end
    
    def sso_auth(access_token)
      call_api(:post, ['accounts', 'authenticate', 'sso_account'],
                      {access_token: access_token}, nil)
    end

    def account_collaborators(token)
      call_api(:get, ['collaborators'], nil, token)
    end

    #issue
    def issues_info(section, token)
      if section.nil?
        call_api(:get, ['issues'], nil, token) 
      else
        call_api(:get, ['issues', section], nil, token) 
      end
    end 
    
    def issue_create(issue_data, token)
      call_api(:post, ['issue'], issue_data, token)
    end

    def issue_info(issue_id, token)
      call_api(:get, ['issue', issue_id], nil, token)
    end

    def issue_update(issue_id, issue_data, token)
      call_api(:put, ['issue', issue_id], issue_data, token)
    end

    def issue_delete(issue_id, token)
      call_api(:delete, ['issue', issue_id], nil, token)
    end 

    #comment
    def comment_create(comment_data, token)
      call_api(:post, ['comment'], comment_data, token)
    end
    
    def comment_delete(comment_data, token)
      call_api(:post, ['comment', 'delete'], comment_data, token)
    end

    def comment_edit(comment_data, token)
      call_api(:put, ['comment'], comment_data, token)
    end


    def call_api(method, resources, data, token)
      url_route = [@config.API_URL, resources].flatten.join'/'
      http = token.nil? ? HTTP : HTTP.auth("Bearer #{token}")

      data.nil? ? result = http.send(method, url_route)
                : result = http.send(method, url_route, json: data)
      ApiResponse.new(result.code, result.to_s)
    end
  end
end
