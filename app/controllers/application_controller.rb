class ApplicationController < ActionController::Base
  http_basic_authenticate_with name: Rails.configuration.journal_auth['user'], password: Rails.configuration.journal_auth['password']
end
