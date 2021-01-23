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
[TMDB](https://www.themoviedb.org/documentation/api)

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
View list of popular tv shows with inifite pagination.
 .Click on the item of TV show to see more details.
  .Inside the detail TV show screen, you can bookmark it or remove it.
View list of your favorite tv shows.
 .Click on the item of favorite TV show to see more details.
  .Inside the favorite detail TV show screen, you can remove it.
Detail Screen: Title, Genre, Overview, Score, Votes average, Image of poster and image of banne.
All data are in pt-BR.

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

* The database and API used by [TMDB](https://www.themoviedb.org/), it's so great.
