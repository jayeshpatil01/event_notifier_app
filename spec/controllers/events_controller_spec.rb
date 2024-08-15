require 'rails_helper'
require Rails.root.join('lib/webmock_stubs')

RSpec.describe EventsController, type: :controller do
  before do
    WebMock.disable_net_connect!(allow_localhost: true)
    WebMockStubs.setup_stubs
    sign_in user
  end

  let(:user) { User.create(email: 'test@example.com', password: 'password', first_name: 'John', last_name: 'Doe') }
  let(:event_a) { build_event_data('EventA') }
  let(:event_b) { build_event_data('EventB') }

  describe 'GET #index' do
    context 'with search query' do
      it 'filters and assigns matching events to @events' do
        allow(EventService).to receive(:get_events).and_return([event_a, event_b])

        get :index, params: { query: 'EventA' }

        expect(assigns(:events)).to include(event_a)
        expect(response).to render_template(:index)
      end
    end

    context 'without search query' do
      it 'assigns @events and @users and renders the index template' do
        get :index
        expect(assigns(:events)).to eq(EventService.get_events)
        expect(assigns(:users)).to eq(UserService.get_users)
        expect(response).to render_template(:index)
      end
    end
  end

  describe 'POST #create_event_a' do
    it 'creates Event A and renders the show_event_response template' do
      post :create_event_a
      expect(assigns(:json_response)[:message]).to eq('Event A created')
      expect(response).to render_template(:show_event_response)
    end
  end

  describe 'POST #create_event_b' do
    context 'when event creation and email sending succeed' do
      it 'creates Event B, sends an email, and renders the show_event_response template' do
        post :create_event_b
        expect(assigns(:json_response)[:message]).to eq('Event B created and email sent')
        expect(response).to render_template(:show_event_response)
      end
    end

    context 'when event creation fails' do
      before do
        stub_request(:post, "https://api.iterable.com/api/events/track")
          .to_return(status: 400, body: { msg: "Invalid parameters", code: "Error" }.to_json)
      end

      it 'renders an error JSON response with status :bad_request' do
        post :create_event_b
        expect(assigns(:json_response)[:error]).to eq('Failed to create Event B')
        expect(response).to have_http_status(:bad_request)
      end
    end
  end
end
