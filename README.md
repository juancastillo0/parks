## ParqMeUp

- Juan Manuel Castillo
- Daniel Giraldo
- Ivan García \n
- Gregorio Ospina \n


### Flutter 

#### Introduction
ParqMeUp is an app that intends to completely automate the parking experience
in order to completely remove human interaction from the process of parking.
We intend to do this by utilizing the sensors (cameras) already used in the
parking lot to recognize and print a ticket with the license plate of the car
that just entered and cross check that license plate with the license plates in
our servers. If there is a user associated with the license plate and that user
has associated payment method. The app will ask the user via a notification if
he wants to accept the parking fee to his payment method.
In this way, the user needs not to stand in a queue to receive a ticket and needs
not to stand in queue to pay his fee, plus he doesnt need to use any physical
money because all transactions are done purely digital.

## How to run
### Client (mobile app)

- Clone project
- Install dependencies "flutter packages get".
- Execute code generation "flutter pub run build_runner build --delete-conflicting-outputs" 
- Start the app with "flutter run".
- Modify the server ip with the "http" icon in the appbar of the user interface in the application.

You can see the web version of the application in https://juancastillo0.github.io/parks/#/

The build apk is in https://github.com/juancastillo0/parks/blob/master/app-release.apk and in https://github.com/juancastillo0/parks/blob/master/app-release-sprint-4.apk for the sprint 4.

### Server

- ssh daniel@157.230.14.37
- samaria95
- cd backend
- yarn start

##### If the port is busy
- fuser -n -k tcp 8080

To execute it locally, see the server code in https://gitlab.com/isis3510_202010_team6/backend. Intructions for running it are in the README.md of the repository.


