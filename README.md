# Job Board Platform - Job Seeker Flow

## Project Overview

This project is a **Job Board Platform** developed in Flutter. The project implements the **Job Seeker Flow**, which allows users to browse jobs, apply for positions, track their applications, and request employer access. This flow is part of a larger capstone project and is fully integrated with the backend APIs.

## Features Included

The Job Seeker Flow includes the following features:

### 1. Job List (Home Screen)

* Displays all available jobs
* Search bar to filter jobs by title, company, or location
* Clicking a job opens the **Job Details Screen**

### 2. Job Details Screen

* Shows full job information including:

  * Job title
  * Company
  * Location
  * Salary
  * Description
* "Apply Now" button to navigate to **Apply Screen**

### 3. Apply Screen

* Input field for CV link
* Submit application to the backend via POST API
* Displays a success message after submission

### 4. My Applications Screen

* Lists all jobs applied by the user
* Displays status badges with colors:

  * Pending → Orange
  * Accepted → Green
  * Rejected → Red

### 5. Employer Request Feature (User Side)

* **Apply to Become Employer Screen**

  * Input fields for company name and optional message
  * Submit request via POST API
* **Employer Request Status Screen**

  * Shows current status of employer request (Pending / Approved / Rejected)
  * Status badge with corresponding color

## API Endpoints Used

* `GET /api/jobs` → Fetch all jobs
* `GET /api/jobs/:id` → Fetch job details
* `POST /api/applications` → Submit job application
* `GET /api/applications` → Fetch user's applications
* `POST /api/employer-request` → Submit request to become employer
* `GET /api/employer-request` → Get status of employer request

## Project Structure

```
lib/
├── models/
│   ├── job_model.dart
│   └── application_model.dart
├── services/
│   └── api_service.dart
├── screens/
│   ├── job_list_screen.dart
│   ├── job_details_screen.dart
│   ├── apply_screen.dart
│   ├── my_applications_screen.dart
│   ├── employer_request_screen.dart
│   └── employer_status_screen.dart
└── main.dart
```

## Installation

1. Clone the repository
2. Run `flutter pub get` to install dependencies
3. Ensure your backend API is running and accessible
4. Run the app using `flutter run`

## UI Flow

1. Job List → Job Details → Apply Screen
2. My Applications → View status badges
3. Employer Request → View Status

## Notes

* The app uses a centralized API service for all HTTP requests.
* All models match the backend data structure.
* Navigation is handled using Flutter's `Navigator`.
* Status badges and employer request screens improve user experience.

## License

This project is part of a university capstone project and is intended for educational purposes.
