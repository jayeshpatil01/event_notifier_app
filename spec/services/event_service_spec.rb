require 'rails_helper'

RSpec.describe EventService do
  before do
    WebMock.disable_net_connect!(allow_localhost: true)
  end

  describe '.track_event' do
    let(:event_data) { build_event_data('EventA') }

    context 'when the event is successfully tracked' do
      it 'returns a success response and stores the event in memory' do
        stub_request(:post, "https://api.iterable.com/api/events/track")
        .to_return(status: 200, body: { msg: "Event created", code: "Success" }.to_json)

        response = EventService.track_event(event_data)

        expect(response.code).to eq('200')
        expect(response.body['msg']).to eq('Event created')
        expect(EventService.get_events).to include(event_data)
      end
    end

    context 'when the event tracking fails with invalid parameters' do
      it 'returns a failure response with error message' do
        stub_request(:post, "https://api.iterable.com/api/events/track")
          .to_return(status: 400, body: { msg: "Invalid parameters", code: "Error" }.to_json)

        response = EventService.track_event(event_data)

        expect(response.code).to eq('400')
        expect(response.body['msg']).to eq('Invalid parameters')
      end
    end
  end

  describe '.send_email' do
    context 'when the email is successfully sent' do
      it 'sends an email through the API' do
        stub_request(:post, "https://api.iterable.com/api/email/target")
        .to_return(status: 200, body: { msg: "Email sent", code: "Success" }.to_json)

        response = EventService.send_email(build_email_data)

        expect(response.code).to eq('200')
        expect(response.body['msg']).to eq('Email sent')
      end
    end

    context 'when the email sending fails with invalid parameters' do
      it 'returns a failure response with error message' do
        stub_request(:post, "https://api.iterable.com/api/email/target")
          .to_return(status: 400, body: { msg: "Invalid parameters", code: "Error" }.to_json)

        response = EventService.send_email(build_email_data)

        expect(response.code).to eq('400')
        expect(response.body['msg']).to eq('Invalid parameters')
      end
    end
  end
end
