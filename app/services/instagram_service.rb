require 'open-uri'

class InstagramService
  def initialize(params)
    @tag = params[:tag]
    @start_time = params[:start_time].to_i
    @end_time = params[:end_time].to_i
  end

  def execute
    token = "268837051.1677ed0.ad3f41f335384dc9bc8d5e910e14b81e"
    url = "https://api.instagram.com/v1/tags/#{@tag}/media/recent?access_token=#{token}"
    response = JSON.load(open(url))
    data = response["data"]
    data.select do |media|
      get_tag_time(media).to_i.between?(@start_time, @end_time)
    end
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

