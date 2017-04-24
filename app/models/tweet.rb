class Tweet < ApplicationRecord
  def self.sync(query)
   client = Twitter::REST::Client.new do |config|
      config.consumer_key        = "YG70zOrdvrut3N41hbo9aBAsk"
      config.consumer_secret     = "5ImUD7aJhvkrdFoEQsvZUYknIYHIwuA5xQChiEJOYes94xLRAa"
      config.access_token        = "856466877458993152-qbAVgMxNorgjP4mcmhlKQbjwXYORRAD"
      config.access_token_secret = "3g7LfTAn0RN9PcDOXKRghTdPqJst68Ki6bQmFLCcWllM3"
   end
   client.search(query).take(10).each do |tweet|
     create(body: tweet.text)
   end 
  end

  before_save :set_sentiment, if: :body_changed?

  scope :positive , -> { where(sentiment: :positive)}
  scope :neutral, -> {where(sentiment: :neutral)}
  scope :negative, -> {where(sentiment: :negative)}

  def set_sentiment
    self.sentiment = $analyzer.sentiment(body)
    self.score = $analyzer.score(body)
  end

end
