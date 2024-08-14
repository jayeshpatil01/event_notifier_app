class UserService
  @@users = {} # In-memory storage for users

  def self.update_user(user_data)
    email = user_data[:email]
    @@users[email] = user_data # Store or update user data in memory

    mock_update_user(user_data) # Simulate API call to update user
  end

  def self.get_user(email)
    @@users[email] # Retrieve user data from in-memory store
  end

  def self.get_users
    @@users # Return all users stored in memory
  end

  private

  def self.mock_update_user(user_data)
    if user_data[:email].nil? || user_data[:userId].nil?
      EventService.mock_response('Invalid parameters', 400)
    else
      EventService.mock_response('User updated', 200)
    end
  end
end
