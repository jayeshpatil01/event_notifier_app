class EventService
  @@events = [] # In-memory storage for events

  def self.track_event(event_data)
    @@events << event_data # Store the event in memory
    mock_track_event(event_data)
  end

  def self.send_email(email_data)
    mock_send_email(email_data)
  end

  def self.get_events
    @@events # Retrieve all events from memory
  end

  private

  def self.mock_track_event(event_data)
    if event_data[:email].nil? || event_data[:eventName].nil?
      mock_response('Invalid parameters', 400)
    else
      mock_response('Event created', 200)
    end
  end

  def self.mock_send_email(email_data)
    if email_data[:recipientEmail].nil?
      mock_response('Invalid parameters', 400)
    else
      mock_response('Email sent', 200)
    end
  end

  def self.mock_response(message, status_code)
    response_body = {
      msg: message,
      code: status_code == 200 ? 'Success' : 'Error',
      params: {}
    }.to_json

    OpenStruct.new(code: status_code.to_s, body: response_body)
  end
end
