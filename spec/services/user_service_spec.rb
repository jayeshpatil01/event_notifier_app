require 'rails_helper'

RSpec.describe UserService do
  before do
    WebMock.disable_net_connect!(allow_localhost: true)
    setup_stubs
  end

  describe '.update_user' do
    let(:user_data) do 
      {
        email: 'test@example.com',
        userId: '123',
        dataFields: { firstName: 'John', lastName: 'Doe' }
      }
    end

    context 'when the user is successfully updated' do
      it 'returns a success response and stores the user in memory' do
        response = UserService.update_user(user_data)

        expect(response.code).to eq('200')
        expect(response.body['msg']).to eq('User updated')
        expect(UserService.get_user('test@example.com')).to eq(user_data)
      end
    end

    context 'when the user update fails with invalid parameters' do
      it 'returns a failure response with an error message' do
        stub_request(:post, "https://api.iterable.com/api/users/update")
          .with(body: hash_including(email: nil))
          .to_return(status: 400, body: { msg: "Invalid parameters", code: "Error" }.to_json)

        invalid_user_data = user_data.merge(email: nil)
        response = UserService.update_user(invalid_user_data)

        expect(response.code).to eq('400')
        expect(response.body['msg']).to eq('Invalid parameters')
      end
    end
  end

  describe '.get_user' do
    let(:user_data) do 
      {
        email: 'test@example.com',
        userId: '123',
        dataFields: { firstName: 'John', lastName: 'Doe' }
      }
    end

    it 'retrieves the user data from memory' do
      UserService.update_user(user_data)
      retrieved_user = UserService.get_user('test@example.com')

      expect(retrieved_user).to eq(user_data)
    end
  end

  # Helper Methods
  def setup_stubs
    WebMock.stub_request(:post, "https://api.iterable.com/api/users/update")
      .to_return(status: 200, body: { msg: "User updated", code: "Success", params: {} }.to_json, headers: { 'Content-Type' => 'application/json' })
  end
end
