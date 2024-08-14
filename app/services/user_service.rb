require 'net/http'
require 'json'

class UserService
  @@users = {} # In-memory storage for users

  def self.update_user(user_data)
    email = user_data[:email]
    @@users[email] = user_data # Store or update user data in memory
    send_user_update_to_api(user_data)
  end

  def self.get_user(email)
    @@users[email] # Retrieve user data from in-memory store
  end

  def self.get_users
    @@users # Return all users stored in memory
  end

  private

  def self.send_user_update_to_api(user_data)
    uri = URI("https://api.iterable.com/api/users/update")
    response = Net::HTTP.post(uri, user_data.to_json, "Content-Type" => "application/json")
    parse_response(response)
  end

  def self.parse_response(response)
    parsed_body = JSON.parse(response.body)
    OpenStruct.new(code: response.code, body: parsed_body)
  end
end
