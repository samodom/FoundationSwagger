Method Swizzling
================

## Method Association

In order to swap a pair of method implementations and better keep track of their correspondence, a method-swizzling record type has been created with a simple inner type for method types:

```swift
class MethodAssociation {
	enum MethodType {
		case instance, `class`
	}

	let owningClass: AnyClass
	let methodType: MethodType
	let originalSelector: Selector
	let alternateSelector: Selector
}
```


## Swizzling

In order to swizzle a method to use an alternate implementation, the idea of replacing an *original* method with a *replacement* method is codified in the API with two separate methods:

```swift
let realSelector = #selector(UIViewController.viewWillAppear(_:))
let mySelector = #selector(UIViewController.my_viewWillAppear(_:))

let association = MethodAssociation(
	forClass: UIViewController.self,
	ofType: .instance,
	originalSelector: realSelector,
	alternateSelector: mySelector
)

/// To start using replacement method in place of original:
association.useAlternateMethod()

/// To restore the original method implementation:
association.useOriginalMethod()
```
