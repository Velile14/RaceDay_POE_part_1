# RaceDay_POE_part_1

### System Description – RaceDay API

The **RaceDay API** is a RESTful Web API developed to support the management of race events and participant activities within the RaceDay system. The API acts as the communication layer between the client application and the RaceDay SQL Server database, allowing authorised users to securely create, retrieve, update, and delete system information.

The system supports two main user roles: **Organisers** and **Participants**. Organisers are responsible for managing race events, creating and maintaining event categories, viewing participant enrolments, and recording race results. Participants can view available events and their categories, enrol themselves in events, and view their own race results. The API also provides public authentication endpoints for user registration and login.

The RaceDay API manages several key areas of the system. These include **user authentication and profiles, events, event categories, participant enrolments, and race results**. Each area is accessed through RESTful endpoints using HTTP methods such as **GET, POST, PUT, and DELETE**. For example, organisers can use the API to create a new event, update its information, or delete an event, while participants can use the API to enrol in an available event and category.

The API uses **role-based access control** to ensure that users can only perform actions appropriate to their assigned role. Public users can register and log in, participants can access participant-related functionality, and organisers have additional permissions for managing events and recording results. This helps protect the system from unauthorised access and prevents users from performing administrative operations they are not permitted to perform.

The RaceDay API follows REST principles by using clearly defined routes and standard HTTP methods. Data is exchanged between the client and server using structured request and response data, allowing the API to provide a consistent interface for the RaceDay application. The API therefore provides the core functionality required to manage the complete race-event lifecycle, from user registration and event creation through to participant enrolment and the recording and viewing of race results.
