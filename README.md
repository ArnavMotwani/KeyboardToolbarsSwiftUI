# KeyboardToolbars

**A SwiftUI pacakge that makes adding floating toolbars to keyboards as simple as adding a single modifier.**

## Requirements:
The package is only compatible with iOS 14 and iPadOS 14 for now.

## Installation: 
In Xcode go to `File -> Swift Packages -> Add Package Dependency` and paste in the repo's url: `https://github.com/ArnavMotwani/KeyboardToolbarsSwiftUI.git` then either select a version or the main branch (I will update the main branch more frequently with minor changes, while the version number will only increase with significant changes)

## Usage:
Currently the package can only be used to add a hide keyboard button above a keyboard. All you need to do is `import KeyboardToolbars` and apply the `.addHideKeyboardButton()` to the root of a view. 

Note: This package is dependant on the safe area of SwiftUI. The `.ignoresSafeArea()` and `.edgesIgnoringSafeArea()` modifiers will cause the toolbar to hide behind the keyboard when these modifier as applied to the same view as  `.addHideKeyboardButton()`.

## Example:
```swift
import SwiftUI
import KeyboardToolbars

struct KeyboardToolbarsTest: View {
    
    @State private var text = ""
    
    var body: some View {
        Form {
            TextField("Text", text: $text)
        }
        .addHideKeyboardButton()
    }
}

struct KeyboardToolbarsTest_Previews: PreviewProvider {
    static var previews: some View {
        KeyboardToolbarsTest()
    }
}
```

```swift
import SwiftUI
import KeyboardToolbars

struct KeyboardToolbarsTest: View {
    
    @State private var text = ""
    
    var body: some View {
        ZStack {
            Color.gray.ignoresSafeArea()
            TextField("Text", text: $text)
        }
        .addHideKeyboardButton()
    }
}

struct KeyboardToolbarsTest_Previews: PreviewProvider {
    static var previews: some View {
        KeyboardToolbarsTest()
    }
}
```

## Planned updates:

- The ability to customize the toolbar
- Ability to add custom buttons to the toolbar.
