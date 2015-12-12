class PagesController < ApplicationController
  def index
    @posts = get_recent_valid_post_with_instagram_service
  end

  private
  def get_recent_valid_post_with_instagram_service
    InstagramService.new({
      tag: params.fetch(:tag, "cats"),
      start_time: params.fetch(:start_time, 0),
      end_time: params.fetch(:end_time, Time.now)
    }).execute
  end
end
