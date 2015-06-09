class TweetProcessor < Processor
  def process_tweet(source, tweet)
    rules = %w[
      .entry-content
      .post-content
      #main-content
      #main\ .content
      #articleContent
      .node-content
      .transcript
      #articleContent
      #content
      .postContent
      .hcf-content
      .entryContent
      .content
      .post
      .entry
      article
      main
      section
    ]

    url = tweet.url.to_s
    guid = url

    item = source.news_items.where(guid: guid).first_or_initialize
    item.title = tweet.text
    item.published_at = tweet.created_at
    item.url = url
    item.retweets = tweet.retweet_count + tweet.favourite_count
    if tweet.retweeted_status.present?
      item.retweets += tweet.retweeted_status.retweet_count
    end

    if (link = tweet.urls.first.try(:expanded_url)) and item.full_text.blank?
      begin
        res = get(link.to_s)
        if html = res.search(rules.join(', ')).find{|f| f.text.strip.length > 100 }
          item.full_text = clear html.to_s
        end
      rescue StandardError, Net::HTTPServiceUnavailable
        item.full_text = ""
      end
    else
      item.destroy if !item.new_record?
      # Tweets ohne Link sind doof
      return
    end
    item.xing = 0
    item.linkedin = 0
    item.fb_likes = 0
    item.gplus = 0

    item.rescore!
  end
end
