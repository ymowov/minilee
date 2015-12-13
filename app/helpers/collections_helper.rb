module CollectionsHelper
  def video_sign
    content_tag(:div, nil, class: "circle") do
      content_tag(:div, nil, class: "arrow-right")
    end
  end

  def post_param(post)
    { "tag_time": Time.at(post["tag_time"]).to_s,
      "data": post,
      "media_type": Post.media_types[post["type"]],
      "url": post["#{post["type"]}s"]["standard_resolution"]["url"],
      "username": post["caption"]["from"]["username"]
    }
  end

  def is_api_hash?(post)
    post.is_a? Hash
  end

  def media_url(post)
    is_api_hash?(post) ? post["images"]["standard_resolution"]["url"] : post.url
  end

  def is_video?(post)
    if is_api_hash?(post)
      post["type"].eql? "video"
    else
      post.video?
    end
  end
end
