require 'twitter'

client = Twitter::REST::Client.new do |config|
  config.consumer_key = ENV['TWITTER_CONSUMER_KEY']
  config.consumer_secret = ENV['TWITTER_CONSUMER_SECRET']
  config.access_token = ENV['TWITTER_ACCESS_TOKEN']
  config.access_token_secret = ENV['TWITTER_ACCESS_TOKEN_SECRET']
end

last_tweet_id = 0

def write tweet
  File.open("lou_tweets.txt", "a") do |f|
    f.puts tweet.created_at
    f.puts tweet.full_text
    f.puts "-----------"
  end
end

while true
  last_tweet = nil
  begin
    last_tweet = client.user_timeline(419555368)[0]
  rescue => ex
    last_tweet = nil
  end
  unless last_tweet.nil?
    if last_tweet_id != last_tweet.id
      write last_tweet
      last_tweet_id = last_tweet.id
    end
  end
  sleep 20
end
