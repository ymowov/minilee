require 'open-uri'

class InstagramService
  def initialize(params)
    @tag_title = params[:tag].downcase
    @start_date = params[:start_date].to_i
    @end_date = params[:end_date].to_i
    @posts = []
    @tag = Tag.find_by_title(@tag_title)
    @max_tag_time = Time.now.to_i
    @max_tag_id = nil
    get_max_tag_data
    # binding.pry # check max_tag_id
  end

  def get_max_tag_data
    if @end_date < Time.now.to_i
      # doesn't need recent 20 posts, find the closest saved tag's timestamps
      tag_time = @tag.find_closest_by_timestamp(@end_date)

      if tag_time
        @max_tag_time = tag_time.timestamp
        @max_tag_id = tag_time.timestamp_id.to_i
        guess_max_tag_id
      end
    end
  end

  def guess_max_tag_id
    if @posts.empty? && @max_tag_time - @end_date > 1000 && @tag.avg_time && @tag.avg_time > 0 # guess'
      @max_tag_id = @max_tag_id.to_i - ((@max_tag_time - @end_date) / @tag.avg_time) * @tag.avg_time_calls.to_i
    end
  end

  def execute
    while @posts.count < 20 && @max_tag_time >= @start_date do
      response = api_response(@max_tag_id)
      create_tag_indexes(response)
      @posts.concat(get_vaild_posts_data(response))
      guess_max_tag_id
    end
    # binding.pry ## check weird array
    @posts
  end

  def create_tag_indexes(response)
    @max_tag_id = response["pagination"]["next_max_id"] # the earliest tag id
    @max_tag_time = response["data"][19]["created_time"].to_i
    min_tag_id = response["pagination"]["next_min_id"] # the oldest tag id
    min_tag_time = response["data"][0]["created_time"].to_i

    @tag.add_timestamp(@max_tag_id, @max_tag_time)
    @tag.add_timestamp(min_tag_id, min_tag_time)

    @tag.add_avg_samples(@max_tag_id, min_tag_id)
  end

  def get_vaild_posts_data(response) # between start & end date
    data = []
    weird = []
    response["data"].each do |media|
      tag_time = get_tag_time(media).to_i
      if tag_time.between?(@start_date, @end_date)
        media["tag_time"] = tag_time
        data << media
      end
      if tag_time == 0
        weird << media
      end
    end
    data
  end

  def get_tag_time(data)
    if data["caption"] && data["caption"]["text"].downcase.include?("##{@tag_title}")
      return data["caption"]["created_time"] # tagged in caption
    else
      data["comments"]["data"].each do |comment| # tagged in comment
        return comment["created_time"] if comment["text"].downcase.include?("##{@tag_title}")
      end
      nil
    end
    nil
  end

  def api_response(max_tag_id=nil) # extract api data
    token = "268837051.1677ed0.ad3f41f335384dc9bc8d5e910e14b81e"
    url = "https://api.instagram.com/v1/tags/#{@tag_title}/media/recent?access_token=#{token}"
    url << "&max_tag_id=#{max_tag_id}" if max_tag_id
    JSON.load(open(url))
  end
end
