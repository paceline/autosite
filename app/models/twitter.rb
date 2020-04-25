class Twitter < Provider

  def sync
    if self.token && self.secret
      oauth_consumer = OAuth::Consumer.new(self.api_key, self.api_secret, { site: "https://api.twitter.com", scheme: :header })
      access_token = OAuth::AccessToken.from_hash(oauth_consumer, { oauth_token: self.token, oauth_token_secret: self.secret})
      response = access_token.get("https://api.twitter.com/1.1/statuses/user_timeline.json?screen_name=#{self.username}")
      feed = JSON.parse(response.body)
      feed.each do |upd|
        if Update.where(originalid: upd['id_str'], provider_id: self.id).count == 0
          status = self.updates.build({
            originalid: upd['id_str'],
            heading: upd['text'].gsub(/https:\/\/.*/, ""),
            link: upd['text'].scan(/https:\/\/.*/),
            posted_on: upd['created_at']
          })
          status.save
        end
      end
    end
  end

end
