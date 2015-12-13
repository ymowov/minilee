class CollectionsController < ApplicationController
  def create
    @collection = Collection.new(collection_params)
    @collection.end_date = @collection.end_date.end_of_day
    @collection.save
    @posts = get_recent_valid_post_with_instagram_service
    render :recent_posts
  end

  def add_posts
    collection = Collection.find(params[:id])
    posts = Post.create(eval(params[:data_str]))
    collection.posts << posts
    redirect_to collection_path(collection)
  end

  def show
    @collection = Collection.find(params[:id])
    @posts = @collection.posts
  end

  private
  def get_recent_valid_post_with_instagram_service
    InstagramService.new({
      tag: @collection.title,
      start_date: @collection.start_date,
      end_date: @collection.end_date
    }).execute
  end

  def collection_params
    params.require(:collection).permit(:title, :start_date, :end_date)
  end

  def posts_params
    params.require(:post).permit(:tag_time, :data, :media_type, :url, :username)
  end
end
