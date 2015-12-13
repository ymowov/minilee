class PagesController < ApplicationController
  def index
    @collection = Collection.new
  end
end
