# Description

iOS application for college course called 'Advanced mobile programming'.

## Features

Application uses [The Rick and Morty API](https://rickandmortyapi.com) to display content. Application uses _Paging_ pattern to fetch data from the API,
page by page, save it to the [RealmSwift](https://www.mongodb.com/docs/realm/sdk/swift/) database and display content on the screen. Content on the screen is searchable using
search bar and _filterable_ using [_Youtube-like_](https://kevin-furjan.hashnode.dev/implement-youtube-like-filtering-in-swiftui) filtering.

Application uses MVVM architecture while the UI is written using SwiftUI framework. For authentication, application uses 'Sign with Google' option.
