# TheNameGame

A matching game for learning the names of WillowTree team members.

## Installation 
Xcode version: 12.4
Target Deployment: 14.1
Launch TheNameGame.xcworkspace for the application


## Overview
The app was built using MVC design pattern and storyboard/UIKit. It leverages Kingfisher for image caching and native URLCaching for data caching. Supports all devices and orientations by making use of Size Classes. Dependencies were installed using Cocoapods. Unit testing is also included.

## Programmatic UI vs Storyboard
When considering which to use, ease of use and code needed were the deciding factors. Size classes are easy to implement using the Interface Builder and Storyboards. The iPad uses the same size class for both orientations. This was worked around by forcing the portrait mode of the iPad to adopt the standard portrait size classes of most iphones.

## Why Kingfisher?
Another consideration came when thinking about image caching. Initially, NSCache was considered as a simple effective method of implementing the feature. [Kingfisher](https://github.com/onevcat/Kingfisher/wiki), however, is an industry accepted solution that would provide a more comprehensive system. A system that would provide a mixed caching design that saves to memory and disk, self clearing when needed, activity indicators, and more. Ultimately it was an easy decision to go with it.

## No Splash Screen on Ipad
Size classes come back to haunt with the launchscreen. Once again there is an issue between different orientations for iPad and I think the figma designs accounted for that since there were no splash screens attached to the iPad specs. Given the lack of control of the launchscreen and not being able to use custom classses, I ultimately decided to keep the splash screen off the iPad. Trying to implement it gave some really ugly results so I felt less was more.

## Some Entries Are Excluded From The Game?
Upon inspecting the API response, I noticed there were entires without headshots so those were excluded. There were also 3 entries that had an image, but the image was not a headshot. The images were WillowTree logos and it felt unfair to use for a game where you need to match a name to a face. These were also excluded. Finally there were some images that were circular or small which didn't work with the design, but I decided to keep them since they had a headshot. 

## Network Retry
This was not in the design specs but I felt was worth implementing since it didn't require much. An alert will allow you to retry a network call to load data if it was not able to load anything from the endpoint or cache. This was intended for situations where there is a lack of service and the user wants to try again when they get service. In case it was something else, the alert also allows the user to return to the main menu.

## Future Features
These are things that given more time would be great to implement.
- Best score saved
- Global Leaderboard
- Background music for main menu and game page

## Testing
Unit testing was included to ensure the API Client and Game logic are implemented as intended. Tests include:
- Testing game starts
- Player move is registered
- Headshot URL is obtained
- Winning condition is met
- Delegation Methods are working
- API Client retrieves data and decodes as expected
- Timer starts and ends for appropriate mode
- Game finishes with correct score
