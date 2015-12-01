# clicker-iOS
USC Clicker iOS Client

To Run:
- Clone the repository
- Go to clicker-iOS folder
- Double click on clicker.xcodeproj, which will open up Xcode
- Click the Run (Play) button at the top and the simulator should open and start

Design Patterns and More:
- The files in the project are sorted into folders designed to make it easier to organize the project. It will be helpful to be familiar with the MVC pattern for iOS. The Controller folder is also broken up by the different functionalities of the app. We do not currently have Model classes.
- We make use of Manager classes, which also assist with scalability and reusability. This allows us to extract the methods to make API calls and also the data and methods associated with a user. You import the Manager in the View Controller and simply call the Manager's methods from there. You can add more methods to the Manager classes or create new Managers as needed.
- There is also a Constants file, where you can find global definitions for variables such as the Base URL for API calls.

Certificates, Provisioning Profiles, and Devices:
- You will likely need to do research into getting the application on your device. In order to test push notifications, you will need an Apple Developer account. More info about transferring ownership TBD.

TestFlight:
-Currently, TestFlight is set up under Julia Lin's Developer Account. Information about transferring ownership TBD.

Known issues:
- Parse push notifications through specific channels are currently not working when the application is closed.
- We are not currently supporting forms of questions other than Multiple Choice, so the presentation of the Multiple Choice View Controller is hard-coded in the AppDelegate. Later on, you will need to get the question type from the push payload and present the appropraite View Controller.

Suggestions for future improvement:
- If desired, you may move to using AFNetworking for make API calls.
- When a user submits an answer, a hard-coded location is currently being sent, as we decided not to move forward with using location to verify a student's attendance. If you decide to indeed proceed with sending location, you will need to send the user's actual location. One recommendation we have, however, is that you look into iBeacon technology, for the most accurate verification of attendance.
- The UI/UX for this iOS app is very simple and practical. As functionality expands, the look and feel of the app should improve. You may want to redesign the app to look "fancier", if you wish to deploy it to the general public.

Additional notes:
- This project was started in Swift but was later completed in Objective-C. The AppDelegate is in Swift, and thus it is important to understand some basics of Swift as you will likely interact with this file at some point. The rest of the project is in Objective-C, but you can definitely continue on in Swift. Make note of the clicker-Bridging-Header.

If there are any questions, please do not hesitate to contact us.



