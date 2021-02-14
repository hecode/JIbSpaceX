# JIbSpaceX
## SpaceX successful launches in the past 3 years and rockets

#### Description:
- Home Page with pull to refresh. (note that there is an indicator for launches with upcoming that changes text and color but they don't appear in this demo under the requirements. (there are no launches that satisfiy being successful and within the past 3 years and has upcoming))

- Rocket Details view.


#### Used tools:

- Swift 5

- iOS 13+

- Xcode 11.3.1 on OS X 10.15.5 (Compatible with Xcode 12)

- CocoaPods

- Used MVVM

#### Used Pods:
- Alamofire
- ImageSlideshow/SDWebImage (SDWebImage and ImageSlideshow and ImageSlideshow's SDWebImage extension)
- RxSwift"
- "RxCocoa"
- "ObjectMapper"


Demo (slow and flickery due to slow machine + simulator + recording + gif):

![](https://i.imgur.com/20lH6Lq.gif)

#### Notes:
- Used storyboard as required since there is very limited views.

- Localizations would be added in an actual app.

- A TabBarController wasn’t used here since only Homepage and details view were required, but depending on further requirements it should be added.

- The api doesn’t specify pagination but it would be very useful specially in a large list api like the launches api.
