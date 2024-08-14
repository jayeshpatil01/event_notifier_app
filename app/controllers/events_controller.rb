class EventsController < ApplicationController

  def index
    @events = EventService.get_events # Retrieve events to display
    @users = UserService.get_users # Retrieve users to display (if needed)
  end

  def create_event_a
    UserService.update_user(user_data)
    response = EventService.track_event(event_data('EventA'))
    handle_response(response, 'Event A created')
  end

  def create_event_b
    UserService.update_user(user_data)
    response = EventService.track_event(event_data('EventB'))
    if response.code == '200'
      email_response = EventService.send_email(email_data)
      handle_response(email_response, 'Event B created and email sent')
    else
      render json: { error: 'Failed to create Event B' }, status: :bad_request
    end
  end

  private

  def handle_response(response, success_message)
    if response.code == '200'
      # render json: { message: success_message }, status: :ok
      @json_response = { message: success_message, data: response.body }
    else
      # render json: { error: JSON.parse(response.body)['msg'] }, status: response.code.to_i
      @json_response = { error: response.body['msg'] }
    end

    render :show_event_response
  end

  def user_data
    {
      email: current_user.email,
      userId: current_user.id.to_s,
      dataFields: {
        firstName: current_user.first_name,
        lastName: current_user.last_name
      },
      preferUserId: true,
      mergeNestedObjects: true,
      createNewFields: true
    }
  end

  def event_data(event_name)
    {
      email: current_user.email,
      userId: current_user.id,
      eventName: event_name,
      id: generate_event_id,
      createdAt: Time.now.to_i,
      dataFields: {},
      createNewFields: true
    }
  end

  def email_data
    {
      recipientEmail: current_user.email,
      recipientUserId: current_user.id,
      dataFields: {},
      allowRepeatMarketingSends: true,
      metadata: {}
    }
  end

  def generate_event_id
    SecureRandom.alphanumeric(10) # Generate a random 9-character alphanumeric string
  end
end
