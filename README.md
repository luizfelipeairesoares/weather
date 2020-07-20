# weather

Weather is an small project that fetches photos and weather from two APIs:
 - [OpenWeather](https://openweathermap.org/api)
 - [Pexels](https://www.pexels.com/api/)

The minimum `iOS` version supported is **13.0**.

---

## Architecture

Since it's a small project, I decided to use the MVC approach, but not the way we see around there.

 - The `View` classes (for example the `MainView`) has all the UI components.
 - The `ViewController` classes manages the data that is shown in the view and communicates with the `Services` classes. `ViewControllers` also conforms to `Protocols` created for them. The idea is to inject the dependencies that the class will need. Also it helps when developing the unit tests.
 - I used the ViewCode approach, so there aren't storyboard files. Except for the `LaunchScreen.storyboard`.
 - There's also a simple `Coordinator` that creates the coordinates the first `ViewController` that needs to be shown.
 - I created an `Environment` class that gets the API Server and API Key from the project's file, that are under `Build Settings > User-Defined`. This approach is helpful when there's Staging and Production environments and we can easily change the environment just changing the scheme.
 - `Code coverage` is at **74%** the last time I tested.

## Running the project

I like to use Gemfiles to manage [Ruby](https://www.ruby-lang.org/en/) dependencies ([CocoaPods](https://cocoapods.org/) and [Fastlane](https://fastlane.tools/)).

If you have [Bundler](https://bundler.io/) installed, follow these steps:
 1. In the project's folder, run `bundle install`.
 2. Then, run `bundle exec pod install`.
 3. Done! 🎉

If Bundler isn't installed, just run `pod install` in the project's folder to install CocoadPods's dependencies.

Then, open `weather.xcworkspace` file.

## Other informations

Reviewing this project I noticed that I could've used git flow but I didn't thought about it when I started it, probably because it was a small project and it was just me pushing the changes.
