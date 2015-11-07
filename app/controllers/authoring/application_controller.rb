class Authoring::ApplicationController < ApplicationController
  before_action :authenticate_author!
  layout 'authoring'
end

