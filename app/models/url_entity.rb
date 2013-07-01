class UrlEntity < ActiveRecord::Base

  attr_accessible :host_name, :expanded_url, :fully_expanded_url, :indice_start, :indice_end

  belongs_to :tweet

  def self.from_twitter_api!(url_data, tweet_id)
    #TODO: process expanded_url to fully_expanded_url
    # url = UrlEntity.find_by_expanded_url(url_data.expanded_url) || UrlEntity.new
    url = UrlEntity.find_by_tweet_id(tweet_id) || UrlEntity.new
    if url.new_record?
      url.tweet_id     = tweet_id
      url.expanded_url = url_data.expanded_url.downcase
      url.fully_expanded_url = UrlEntity.fully_expand_url(url_data.expanded_url)
      url.host_name = UrlEntity.get_host_without_www(url.fully_expanded_url)
      url.indice_start = url_data.indices[0]
      url.indice_end   = url_data.indices[1]
      url.save
      url.check_article
    end
    return url

  end

  def self.fully_expand_url(url)
    host = UrlEntity.get_host_without_www(url)
    # if host == "bit.ly"
    #   long_url = fully_expand_url(Bitly.client.expand(url_object.path[1..-1]).long_url)
    #   return long_url
    if Host.find_by_name_and_category(host,"shortner")
      long_url = fully_expand_url(get_long_url(url))
      return long_url
    else
      return url
    end
  end

  def self.get_long_url(short_url)
    uri = URI.parse(short_url)
    http = Net::HTTP.new(uri.host)
    response = http.get(uri.path)
    if response.code == "200"
      short_url
    else
      response.fetch('location')
    end
  end

  def self.get_host_without_www(url)
    uri = URI.parse(url)
    uri = URI.parse("http://#{url}") if uri.scheme.nil?
    host = uri.host.downcase
    host.start_with?('www.') ? host[4..-1] : host
  end

  def check_article
    t = self.tweet
    t.text_stripped = t.text
    t.text_stripped[indice_start, indice_end] = ""
    if !Host.find_by_name(host_name)
      t.is_article = true
    else
      t.is_article = false
    end
    t.save!
  end


end
