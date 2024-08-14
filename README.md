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
