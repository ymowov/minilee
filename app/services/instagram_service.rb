require 'open-uri'

class InstagramService
  def initialize(params)
    @tag = params[:tag]
    @start_date = params[:start_date].to_i
    @end_date = params[:end_date].to_i
  end

  def execute
    data = []
    token = "268837051.1677ed0.ad3f41f335384dc9bc8d5e910e14b81e"
    url = "https://api.instagram.com/v1/tags/#{@tag}/media/recent?access_token=#{token}"
    response = JSON.load(open(url))
    response = response["data"]
    response.each do |media|
      tag_time = get_tag_time(media).to_i
      if tag_time.between?(@start_date, @end_date)
        media["tag_time"] = tag_time
        data << media
      end
    end
    data
  end

  def get_tag_time(data)
    if data["caption"]["text"].downcase.include?("##{@tag}")
      data["caption"]["created_time"]
    else
      data["comments"]["data"].each do |comment|
        return comment["created_time"] if comment["text"].downcase.include?("##{@tag}")
      end
    end
  end
end

