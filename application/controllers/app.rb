require 'roda'
require 'erb'

module TalkUp
  # Base class for TalkUp Web Application
  class App < Roda
    plugin :render, views: 'presentation/views'
    plugin :assets, css: 'style.css', path: './presentation/assets/'
    # plugin :public, root: 'presentation/public'
    plugin :flash
    plugin :multi_route

    require_relative 'auth'
    require_relative 'account'



    route do |routing|
      routing.assets
      account_info = SecureSession.new(session).get(:current_account)
      account = build_representer(account_info, AccountRepresenter)
      @current_account = Views::Account.new(account)
      
      routing.multi_route
      ## routing.public

      # GET '/'
      routing.root do
        view 'home', locals: { current_account: @current_account}
      end

    end
  end
end
