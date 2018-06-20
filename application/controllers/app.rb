require 'roda'
require 'erb'

module TalkUp
  # Base class for TalkUp Web Application
  class App < Roda
    plugin :render, views: 'presentation/views'
    plugin :assets, css: 'style.css', js: 'application.js', path: './presentation/assets/'
    # plugin :public, root: 'presentation/public'
    plugin :flash
    plugin :multi_route

    require_relative 'auth'
    require_relative 'account'
    require_relative 'issues'
    require_relative 'comment'



    route do |routing|
      routing.assets
      account_info = SecureSession.new(session).get(:current_account)
      account = account_info == nil ? nil : AccountRepresenter.new(OpenStruct.new).from_json(account_info)  
      @current_account = View::Account.new(account)
      routing.multi_route
      ## routing.public

      # GET '/'
      routing.root do
        view 'home', locals: { current_account: @current_account}
      end

    end
  end
end
