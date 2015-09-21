module ForemanOpensearch
  class OpensearchController < ApplicationController
    def search
      target_controller, _sep, query = params[:q].partition(':')
      redirect_to :controller => "/#{target_controller}", :action => :index, :search => query
    end

    def description
    end
  end
end
