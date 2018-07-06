class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper Cartify::Engine.helpers
  include Cartify::CurrentSession
end
