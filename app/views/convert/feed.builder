
xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title @data[:title]
    xml.link @feed_url

    for post in @data[:items]
        xml.item do
          xml.title post[:title]
          xml.description post[:content]
          xml.pubDate post[:date]
        xml.link post[:url]
      end
    end
  end
end