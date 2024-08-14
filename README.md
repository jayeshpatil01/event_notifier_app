# EventNotifierApp

## Overview

EventNotifierApp is a Ruby on Rails application that integrates with the Iterable API to create and manage events associated with users. The application demonstrates how to mock API requests using WebMock during development and testing.

## Features

- Create events (`EventA`, `EventB`) associated with users.
- Send email notifications for specific events.
- Mock third-party API interactions for development and testing.
- Simple user authentication with Devise.

## Setup Instructions

### Prerequisites

- Ruby 3.0.7
- Rails 6.1.7.8
- SQLite (or your preferred database)
- Bundler

### Installation

1. **Clone the Repository:**

   ```bash
   git clone https://github.com/yourusername/event_notifier_app.git
   cd event_notifier_app
   ```

2. **Install Dependencies:**

   ```bash
   bundle install
   ```

3. **Setup Database:**

   Run the following commands to set up the database:

   ```bash
   rails db:create
   rails db:migrate
   ```

4. **Install WebMock and RSpec:**

   Ensure WebMock is set up for development and testing environments:

   ```bash
   bundle exec rails generate rspec:install
   ```

5. **Run the Tests:**

   Ensure everything is working by running the test suite:

   ```bash
   bundle exec rspec
   ```

6. **Start the Rails Server:**

   ```bash
   rails server
   ```

7. **Access the Application:**

   Open your web browser and navigate to http://localhost:3000.

### Installation

   This application uses RSpec for testing and WebMock for mocking external API calls.

   To run the test suite:

   ```bash
   bundle exec rspec
   ```

### Contributing

   Feel free to fork this repository and submit pull requests. For major changes, please open an issue to discuss what you would like to change.
