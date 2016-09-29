To run the sample code, open the project in Xcode and run it on the simulator or a device. I made a simple app that writes and speaks numbers in different languages. It works on iOS 8. 

The sample code shows a prototype of an idea I have for a view controller. It is a persistent menu that can be accessed from anywhere in the app. 

It wouldn't have the disadvantages of other root view controllers such as:
- Tab bar controller: only a max of 5 options are on the screen and it persists the navigation stack of each tab.
- Navigation controller: the navigation is linear and you can't go from one section of an app to the next without first having to go to the root menu (hitting "Back" a bunch of times).
- Side bar/drawer controller: a custom controller that opens a menu from the left side. To make the menu available from anywhere in the app (by swiping from the left edge of the screen), it interferes with the back gesture of a nav controller.

The base class is called RNSlidingViewController and the specific implementation is a subclass called RNRootViewController. 
