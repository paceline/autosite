class Github < Provider

  def sync
    if self.token
      uri = URI("https://api.github.com/users/#{self.username}/events")
      req = Net::HTTP::Get.new(uri)
      req["Authorization"] = "Bearer #{self.token}"
      response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == 'https') { |http| http.request(req) }
      feed = JSON.parse(response.body)
      raise feed.first.inspect
      feed.each do |upd|
        if Update.where(originalid: upd['id'], provider_id: self.id).count == 0
          status = self.updates.build({ originalid: upd['id'], link: "https://github.com/#{upd['repo']['name']}", posted_on: upd['created_at'] })
          case upd['type']
            when "PullRequestReviewCommentEvent", "CommitCommentEvent"
              status.heading = "commented"
              status.content = upd["payload"]["comment"]["body"]
						  status.link = upd["payload"]["comment"]["html_url"]
					  when "CreateEvent"
						  ref_type = upd["payload"]["ref_type"]
						  ref = upd["repo"]["name"]
              ref = upd["payload"]["ref"] if ref_type != "repository"
						  status.heading = "created " + ref_type + " " + ref
					  when "DeleteEvent"
						  status.heading = "deleted " + upd["payload"]["ref_type"]
					  when "DownloadEvent"
						  status.heading = "uploaded " + upd["payload"]["download"]["name"]
						  status.link = upd["payload"]["download"]["html_url"]
					  when "FollowEvent"
						  status.heading = "is now following " + upd["payload"]["target"]["login"]
						  status.link = upd["payload"]["target"]["html_url"]
					  when "ForkEvent"
						  status.heading = "forked " + upd["repo"]["name"]
					  when "ForkApplyEvent"
						  status.heading = "applied fork to " + upd["payload"]["head"]
					  when "GistEvent"
						  status.heading = upd["payload"]["action"] + "d " + upd["payload"]["gist"]["description"]
						  status.link = upd["payload"]["gist"]["html_url"]
					  when "GollumEvent"
						  status.heading = upd["payload"]["pages"][0]["action"] + " page"
						  status.content = upd["payload"]["pages"][0]["page_name"]
						  status.link = upd["payload"]["pages"][0]["html_url"]
					  when "IssueCommentEvent"
						  status.heading = upd["payload"]["action"] + " on issue \#" +  upd["payload"]["issue"]["number"].to_s
						  status.content = upd["payload"]["comment"]["body"]
						  status.link = upd["payload"]["issue"]["html_url"]
					  when "IssuesEvent"
						  status.heading = upd["payload"]["action"] + " issue \#" +  upd["payload"]["issue"]["number"].to_s
						  status.content = upd["payload"]["issue"]["body"]
						  status.link = upd["payload"]["issue"]["html_url"]
					  when "MemberEvent"
						  status.heading = upd["payload"]["action"] + " " +  upd["payload"]["member"]["login"] + " to " + upd["repo"]["name"]
						  status.link = upd["payload"]["member"]["html_url"]
					  when "PublicEvent"
						  status.heading = "Open sourced " + upd["repo"]["name"]
					  when "PullRequestEvent"
						  status.heading = upd["payload"]["action"] + " pull request"
						  status.content = upd["payload"]["pull_request"]["title"]
						  status.link = upd["payload"]["pull_request"]["html_url"]
					  when "PushEvent"
						  status.heading = "pushed to " + upd["repo"]["name"]
						  status.content = upd["payload"]["commits"][0]["message"] unless upd["payload"]["commits"].blank?
					  when "TeamAddEvent"
						  status.heading = "added " + upd["payload"]["user"]["login"] + " to " + upd["payload"]["team"]["name"]
						  status.link = upd["payload"]["user"]["html_url"]
					  when "WatchEvent"
						  status.heading = upd["payload"]["action"] + " watching " + upd["repo"]["name"]
          end
          status.save
        end
      end
    end
  end

end
