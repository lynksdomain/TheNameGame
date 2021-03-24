# TheNameGame

A matching game for learning the names of WillowTree team members.

## Overview
The app was built using MVC design pattern and storyboard/UIKit. It leverages Kingfisher for image caching and native URLCaching for data caching. Supports all devices and orientations by making use of Size Classes. Dependancies were installed using Cocoapods. Unit testing is also included

## Programmatic UI vs Storyboard
When considering which to use, ease of use and code needed were the deciding factors. Size classes are easy to implement and design with when using the Interface Builder and Storyboards. The iPad is an interesting case when it comes to orientation as both use the same size class. This was worked around by forcing the portrait mode of the iPad to adopt the standard portrait size classes of most iphones.

## Why Kingfisher?
Another consideration came when thinking about image caching. Initially, NSCache was considered as a simple effective method of implementing the feature. [Kingfisher](https://github.com/onevcat/Kingfisher/wiki), however, is an industry accepted solution that would provide a more comprehensive system. A system that would provide a mixed caching design that saves to memory and disk, self clearing when needed, activity indicators, and more. Ultimately it was an easy decision to go with it.

## Some Entries Are Excluded From The Game?
Upon inspecting the api response, I noticed there were entires without headshots so those were excluded. There were also 3 entries that had an image, but the image was not a headshot. The images were WillowTree logos and it felt unfair to use for a game where you need to match a name to a face. These were also excluded. Finally there are some images that were circular or small which didn't work with the design, but I decided to keep them since they had a headshot. 

## Network Retry
This was not in the design specs but I felt was worth implementing since it didn't require much. An alert will alow you to retry a network call to load data if it is not able to load anything from the endpoint or cache. This was intended for situations where there is a lack of service and the user wants to try again when they get service. In case it is something else, the alert also allows you to return to the main menu.

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
