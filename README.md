# KKCarPlayManager

**KKCarPlayManager** provides a simple, clear and declarative way to implement
the functionalities of [CarPlay](https://www.apple.com/ios/carplay/).

## Requirement

- Xcode
- Swift 4.2 or above
- iOS 8.0 or above

## Installation

You can install the package via Swift Package Manager or CocoaPods.

## Example

The project has an example project. Go to the `Example` folder, run `pod install`,
open `Example.xcworkspace`, build and run the example app.

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

import KKCarPlayManager
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

Actually these nodes are  instances of `KKBasicContentItem`. It is a subclass of
`MPContentItem`, and you can subclass `KKBasicContentItem` for your own need.

## Items/Nodes

We added three methods on `KKBasicContentItem`:

- `children`: A list of `KKBasicContentItem`.
- `loadChildren(callback:)`: Ask the item to load its children.
- `play(callback:)`: Play the item.

There are two kinds of items/nodes, one is containers while another is playable
items.

### Containers

A container could be list a playlist or an album. It has it children. When you
select a container on the CarPlay screen, `loadChildren(callback:)` would be
called and the CarPlay screen goes to the next level and present its children
items in a table UI.

If you want to load children items from a file or from the Internet, subclass a
KKBasicContentItem, set `isPlayable` to false and `isContainer` to true, do your
loading in `loadChildren(callback:)` and remember to call the callback closure.

KKCarPlayManager made a built-in container item type, KKStaticContainerItem. You
can just use the class if you have a static list.

### Playable Items

A playable item could be a song track, an audio book and so on. When a playable
item is selected, the `play(callback:)` method would be called. You should
create your own subclasses for playable items in your app, since we are hardly
to know how your player works and creates classes for you.

