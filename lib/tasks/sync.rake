namespace :sync do
  task feeds: [:environment] do
    Feed.all.each do |feed|
      content = Feedjira::Feed.fetch_and_parse feed.url
      content.entries.each do |entry|
        local_entry = feed.entries.where(title: entry.title).first_or_initialize

          response = HTTParty.get("http://api.smmry.com/?&SM_API_KEY=33988A28D7&SM_URL=" + entry.url + "&SM_LENGTH=4&SM_WITH_BREAK")
          entry.content = response["sm_api_content"]
          sleep(0.5)


        local_entry.update_attributes(author: entry.author, url: entry.url, published: entry.published, summary: entry.summary, content: entry.content)
        
        p "Synced Entry - #{entry.title}"
        p "Synced Entry - #{entry.content}"
        p "Log - #{response["sm_api_message"]}"
        p "Log - #{response["sm_api_error"]}"

      end
      p "Synced Feed - #{feed.name}"
    end
  end
end



