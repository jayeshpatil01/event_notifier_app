require 'net/http'
require 'json'
require 'securerandom'

class EventService
  @@events = [] # In-memory storage for events

  def self.track_event(event_data)
    @@events << event_data # Store the event in memory
    send_event_to_api(event_data)
  end

  def self.send_email(email_data)
    send_email_to_api(email_data)
  end

  def self.get_events
    @@events # Retrieve all events from memory
  end

  private

  def self.send_event_to_api(event_data)
    uri = URI("https://api.iterable.com/api/events/track")
    response = Net::HTTP.post(uri, event_data.to_json, "Content-Type" => "application/json")
    parse_response(response)
  end

  def self.send_email_to_api(email_data)
    uri = URI("https://api.iterable.com/api/email/target")
    response = Net::HTTP.post(uri, email_data.to_json, "Content-Type" => "application/json")
    parse_response(response)
  end

  def self.parse_response(response)
    parsed_body = JSON.parse(response.body)
    OpenStruct.new(code: response.code, body: parsed_body)
  end
end
