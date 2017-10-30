# iOS Challenge

The main goal of this challenge is allow us to know better your skills.
This challenge must be done completely by yourself.

## Instructions
1. Fork this project
2. Then implement the project according project description below
3. Make a Pull Request with all your code

## Project Description
You have to make an app that will list the most popular github public repositories related to Swift. You should use [Github API](https://developer.github.com/v3/) for search the needed data.

The app should show initially a paged list with the repositories, sort descending.
This is an example of an API call: https://api.github.com/search/repositories?q=language:Swift&sort=stars&page=1

Each repository must show its name, description, author photo, number of stars and number of forks.

When you tap in a repository, you must show a new screen with all repository’s pull requests, containing its title, date, body, author’s name and photo.

When you tap in a pull request, you must open Safari showing the PR’s page.

You can base your UI in this mockup, but feel free to develop whatever you want!
![mockup](https://raw.githubusercontent.com/myfreecomm/desafio-mobile-ios/master/mockup-ios.png)

## Project requirements:
* Target: > iOS 9.*
* Use .gitignore
* Storyboard and autolayout
* Cocoapods or Carthage for dependencies
* Alamofire or an network framework
* Unit test

## Would be nice, but not required:
* You use RxSwift
* Use CoreData / Realm / Firebase to locally persist
* Your app be universal
* Image cache. Ex: SDWebImage/Kingfisher/AlamofireImage
* Dependency Injection

## Test
Your project will be evaluated according to the following criteria:
* Does your project have the basics requirements?
* Do you documented your project (configuration, environment, code)?


If you have any question, feel free to contact us!
That’s it! Good luck ;)
