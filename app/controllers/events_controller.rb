class EventsController < ApplicationController

  def index
    @events = EventService.get_events # Retrieve events to display
    @users = UserService.get_users # Retrieve users to display (if needed)
  end

  def create_event_a
    user_data = {
      email: current_user.email,
      userId: current_user.id.to_s,
      dataFields:
        {
          firstName: 'John',
          lastName: 'Doe'
        },
      preferUserId: true,
      mergeNestedObjects: true,
      createNewFields: true
    }
    UserService.update_user(user_data)

    event_data = {
      email: current_user.email,
      userId: current_user.id,
      eventName: 'EventA',
      id: 'event_a_id',
      createdAt: Time.now.to_i,
      dataFields: {},
      createNewFields: true
    }
    response = EventService.track_event(event_data)
    handle_response(response, 'Event A created')
  end

  def create_event_b
    user_data = {
      email: current_user.email,
      userId: current_user.id,
      dataFields:
        { 
          firstName: 'John',
          lastName: 'Doe'
        },
      preferUserId: true,
      mergeNestedObjects: true,
      createNewFields: true
    }
    UserService.update_user(user_data)

    event_data = {
      email: current_user.email,
      userId: current_user.id,
      eventName: 'EventB',
      id: 'event_b_id',
      createdAt: Time.now.to_i,
      dataFields: {},
      createNewFields: true
    }
    response = EventService.track_event(event_data)
    if response.code == '200'
      email_data = {
        recipientEmail: current_user.email,
        recipientUserId: current_user.id,
        dataFields: {},
        allowRepeatMarketingSends: true,
        metadata: {}
      }
      email_response = EventService.send_email(email_data)
      handle_response(email_response, 'Event B created and email sent')
    else
      render json: { error: 'Failed to create Event B' }, status: :bad_request
    end
  end

  private

  def handle_response(response, success_message)
    if response.code == '200'
      render json: { message: success_message }, status: :ok
    else
      render json: { error: JSON.parse(response.body)['msg'] }, status: response.code.to_i
    end
  end
end
