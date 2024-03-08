# Find Boarding Backend

Welcome to the Find Boarding backend repository! This repository contains the Django backend code for the Find Boarding project, an application aimed at facilitating university students in finding suitable boarding houses with ease.

## Introduction

The Find Boarding backend serves as the core infrastructure for managing user authentication, boarding house information, and user interactions. Built with Django, it provides a robust foundation for seamless communication between the frontend and the database.

## Scope

The scope of the Find Boarding backend encompasses:

- Enabling university students to find boarding houses easily and access detailed information about available accommodations.
- Empowering boarding house owners to efficiently reach out to students in need of accommodation.
- Implementing essential functionalities such as user authentication, boarding house management, and data serialization.

## Main Features

- User authentication system leveraging Django's built-in authentication functionalities.
- Models for Tenant, Owner, BoardingHouse, and Image to capture key data entities.
- Serializers for seamless conversion of complex data types between backend and frontend.
- API endpoints and views for functionalities such as saving and removing boarding information.

## UI Design

The backend primarily serves as the data processing and management component of the application. UI design and user interaction are handled by the frontend, built with Flutter.


## Implementation Details

- **Models:** Tenant, Owner, BoardingHouse, Image
- **Serializers:** TenantSerializer, OwnerSerializer, SavedBoardingsSerializer
- **Views:** Django views and API endpoints for various functionalities
- **Authentication Flow:** Token-based authentication system integrated with Django's authentication system

## Getting Started

To set up the Find Boarding backend locally, follow these steps:

1. Clone this repository to your local machine.
2. Install the required dependencies listed in `requirements.txt`.
3. Set up your Django environment and configure database settings in `settings.py`.
4. Run migrations to create database tables: `python manage.py migrate`.
5. Start the Django development server: `python manage.py runserver`.



