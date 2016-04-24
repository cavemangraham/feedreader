include ActionView::Helpers::SanitizeHelper

namespace :sync do
  task feeds: [:environment] do
    Feed.all.each do |feed|
      content = Feedjira::Feed.fetch_and_parse feed.url
      content.entries.each do |entry|
        local_entry = feed.entries.where(title: entry.title).first_or_initialize
        local_entry.update_attributes(author: entry.author, url: entry.url, published: entry.published)
        p "Synced Entry - #{entry.title}"
        Entry.summary = strip_tags(entry.summary)
        p "Synced Summary - #{entry.summary}"
      end
      p "Synced Feed - #{feed.name}"
    end
  end
end



