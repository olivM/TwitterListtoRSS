class ConvertController < ApplicationController

  def index
    
    
  end

  def feed

    @q = params[:q]
    @feed_url = "http://twitterlisttorss.heroku.com/convert/feed/?q=#{@q}"

    @data = Rails.cache.read(@q)
    
    if @data.nil?

      require 'open-uri'

      d = Nokogiri::HTML(open(@q))
      
      items = d.css('.statuses li').collect do |li|

        url = li.css('.entry-date').first['href']
        content = li.css('.entry-content').first.content

        date = li.css('.timestamp').first['data'].gsub(/^\{time\:'/, '').gsub(/'\}$/, '')

        {:url => url, :title => content, :content => content, :date => date}

      end
      
      @data = { :items => items, :title => d.css('title').text }

      Rails.cache.write(@q, @data, :expires_in => 10.minutes)

    end
    

  end
end
