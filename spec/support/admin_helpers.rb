# frozen_string_literal: true

module AdminHelpers
  def login_as_admin
    credentials = Rails.application.secrets[:admin_credentials]
    post '/admin/login', params: { username: credentials[:username],
                                   password: credentials[:password] }
  end
end
