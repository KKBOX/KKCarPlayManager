# KKCarPlayManager

**KKCarPlayManager** provides a simple, clear and declarative way to implement
the functionalities of [CarPlay](https://www.apple.com/ios/carplay/).

## Requirement

- Xcode
- Swift 4.2 or above
- iOS 8.0 or above

## Installation

You can install the package via Swift Package Manager or CocoaPods.

## Getting Started

Apple does not allow a CarPlay audio app to customize user interface./ You don't
call any method on CarPlay, but let
[MPPlayableContentManager](https://developer.apple.com/documentation/mediaplayer/mpplayablecontentmanager)
to call you, discover your contents, and list them in a structured table user
interface.

KKCarPlayManager helps you to build your contents into a tree to be discovered.
KKCarPlayManager already implemented the data source and delegate of
MPPlayableContentManager for you, and all you need to do is to give
KKCarPlayManager a root node and its subnodes. For example:

``` swift
// Import required modules.

import MediaPlayer
import AVFoundation

// You should set at least one command of MPRemoteCommandCenter, otherwise
// MPPlayableContentManager won't call it data source and delegate.
MPRemoteCommandCenter.shared().playCommand.addTarget { event in
    return .success
}

// Create a root node.
let rooNode = KKStaticContainerItem(identifier: "root", title: "Root", children: [
    KKStaticContainerItem(identifier: "folder1", title: "Folder 1", children: [
        PlayItem(identifier: "Song_1_1", title: "Song name", url: "song URL..."),
        PlayItem(identifier: "Song_1_2", title: "Song name", url: "song URL..."),
        ]),
    KKStaticContainerItem(identifier: "folder_2", title: "Folder 2", children: [
        PlayItem(identifier: "Song_2_1", title: "Song name", url: "song URL..."),
        PlayItem(identifier: "Song_2_2", title: "Song name", url: "song URL...")
        ]),
    ]
)

// Create your manager.
manager = KKCarPlayManager(rootNode: rooNode)

// Sets the data source and delegate of MPPlayableContentManager to the manager.
manager?.activate()
```