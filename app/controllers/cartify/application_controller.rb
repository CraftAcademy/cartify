module Cartify
  class ApplicationController < ::ApplicationController
    protect_from_forgery with: :exception
    include Cartify::Authenticatable

    respond_to :html, :js
  end
end
