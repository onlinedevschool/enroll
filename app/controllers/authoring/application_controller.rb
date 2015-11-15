class Authoring::ApplicationController < ApplicationController
  before_action :authorize
  layout 'authoring'

private

  def authorize
    if author_signed_in?
      authenticate_author!
    else
      authenticate_instructor!
    end
  end

end

