<h1 align="center"> TMDB App </h1> <br>

This is a application powered by me with TMDB database that provides the list of popular tv shows around the world.

## Getting Started

You can only download the project to your mac.

### Prerequisites

** You Need **

```
XCode 12 *
Connection with Internet 
Get a Key on the Website below
```
[TMDB ApiKey](https://www.themoviedb.org/documentation/api)

### Instalation

Double click on newsApp.xcodeproj<br>
go to folder Util > APIProvider.swfit

```swift
      class APIProvider {
        private let kApikey = "" //PUT-YOUR-KEY-HERE
        ...
      }
```

And run project

## Features

```
1. View list of popular tv shows with inifite pagination.
 1.1. Click on the item of TV show to see more details.
  1.2. Inside the detail TV show screen, you can bookmark it or remove it.
2. View list of your favorite tv shows.
 2.1. Click on the item of favorite TV show to see more details.
  2.2. Inside the favorite detail TV show screen, you can remove it.
3. Detail Screen: Title, Genre, Overview, Score, Votes average, Image of poster and image of banne.
4. All data are in pt-BR.
```

## Supported ROM's 

```
iOS 13*
iPADOS 13*
```

## Built With

* [Swift](https://swift.org) - 
*  MVVM - Architecture used
*  View-Code layout

## Authors

* **Cassu**


## Credits
<code><img height="30" src="https://www.themoviedb.org/assets/2/v4/logos/v2/blue_long_2-9665a76b1ae401a510ec1e0ca40ddcb3b0cfe45f1d51b77a308fea0845885648.svg"></code>
* The database and API used by [TMDB](https://www.themoviedb.org/), it's so great.
