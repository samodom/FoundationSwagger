Method Swizzling
================

### Method Profiles

Each method is represented by a selector, a method pointer and a pointer to an implementation.

```swift
struct MethodRecord {
	let selector: Selector
	let method: Method
	let implementation: IMP
	
	init(selector: Selector)
}
```


### Swizzling

In order to swizzle a method to use an alternate method, the idea of replacing an *original* method with a *replacement* method is codified in the API with two separate methods:

```swift
let realSelector = #selector(UIViewController.viewWillAppear(_:))
let originalMethod = MethodProfile(selector: realSelector)

let mySelector = #selector(UIViewController.my_viewWillAppear(_:))
let replacementMethod = MethodProfile(selector: mySelector)

/// To start using replacement method in place of original
replaceMethod(originalMethod, with: replacementMethod)

/// To restore the original method implementation
restoreMethod(originalMethod)
```
