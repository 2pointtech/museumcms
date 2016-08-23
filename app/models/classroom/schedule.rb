require 'open-uri'
class Classroom::Schedule < ActiveRecord::Base
  attr_accessible :feed_url, :title

  def events
    @events = []
    return if feed_url.blank?

    url = "https://www.googleapis.com/calendar/v3/calendars/#{feed_url}/events?key=#{Rails.application.config.google_api_key}"
    json = JSON.load(open(url))

    @items = []
    for event in json['items']
      if event['kind'] == 'calendar#event'
        item = {}
        startTime = Time.parse (event['start']['dateTime'] or event['start']['date'])
        endTime = Time.parse (event['end']['dateTime'] or event['start']['date'])
        item[:when] = startTime
        item[:category] = ''
        item[:length] = (endTime - startTime)
        item[:title] = event['summary']
        @items << item
      end
    end
    @items
  end
end

