require 'webmock'
include WebMock::API

WebMock.enable!

module WebMockStubs
  def self.setup_stubs
    # Disable external requests except localhost
    WebMock.disable_net_connect!(allow_localhost: true)

    WebMock.stub_request(:post, "https://api.iterable.com/api/users/update").
      to_return(
        status: 200,
        body: {
          msg: "User updated",
          code: "Success",
          params: {}
        }.to_json,
        headers: { 'Content-Type' => 'application/json' }
      )

    WebMock.stub_request(:post, "https://api.iterable.com/api/events/track").
      to_return(
        status: 200,
        body: {
          msg: "Event created",
          code: "Success",
          params: {}
        }.to_json,
        headers: { 'Content-Type' => 'application/json' }
      )

    WebMock.stub_request(:post, "https://api.iterable.com/api/email/target").
      to_return(
        status: 200,
        body: {
          msg: "Email sent",
          code: "Success",
          params: {}
        }.to_json,
        headers: { 'Content-Type' => 'application/json' }
      )

    # Debugging WebMock interactions
    WebMock.allow_net_connect!
    WebMock.after_request do |request_signature, response|
      Rails.logger.debug "WebMock intercepted: #{request_signature}"
    end
  end
end
