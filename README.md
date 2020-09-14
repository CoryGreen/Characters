# Breaking Bad API

## Build & Running 
To build the project:
1. Open the `.xcodeproj` file
2. Run the application (`CMD + R`) on your chosen simluator 

## Methodology & Reasoning
During the process a number of decisions were made, see below the choices that were made and the reasons why 

### Design Patterns
* The application follows the Model View Presenter pattern at its core. 
* MVC was not option due to its tight coupling. 
* V.I.P.E.R. would have been overly complicated for the current scope
* MVVM was another option but for this I wanted to challenge myself with MVP
* Dependency Injection has been well utilised
* Delegation is used to communicate between the presenters & coordinators
* The Namespace pattern could have been used to solve the magical strings problem

### Networking
* The network layer uses a custom protocol-based approach
* A 3rd party framework like [Alamofire](https://github.com/Alamofire/Alamofire) or [Moya](https://github.com/Moya/Moya) could have been used. However, I wanted to highlight my ability to use protocols
* `Codable` protocol was used to parsing the `JSON` response due to its ease of use

### Data Persistence
* Currently there is no data persistence
* Core Data would have been suitable choice along with [Realm](https://realm.io/)

### Testing
* A Test-Driven approach was used to help maintain code quality
* XCTest framework was used due to its ease of use
* Code Coverage currently sits at around 90%
* More unit tests could be implemented; the current ones mostly focus on positive use cases; edge cases & negative cases should be tested

### 3rd Party Tools/Frameworks
* [Swift Package Manager] (https://swift.org/package-manager/) was used to manage the 3rd party tools
* SPM was chosen as I wanted to keep things easy during the build process
* [Carthage](https://github.com/Carthage/Carthage) & [CocoaPods](https://github.com/CocoaPods/CocoaPods) are suitable alternative
* In order to keep things somewhat simple, [Kingfisher](https://github.com/onevcat/Kingfisher) was used to handle image fetching and [MBProgressHUD](https://github.com/jdg/MBProgressHUD) to handle display of the activity indicator 
