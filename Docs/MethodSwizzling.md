Method Swizzling
================

## Method Surrogate

In order to swap a pair of method implementations and better keep track of their correspondence, a method-swizzling record type has been created with a simple outer type for method types:

```swift
enum MethodType {
	case instance, `class`
}

class MethodSurrogate {
	let owningClass: AnyClass
	let methodType: MethodType
	let originalSelector: Selector
	let alternateSelector: Selector
}
```

Selector pairs may represent swappable accessors or mutators.


## Swizzling

In order to swizzle a method to use an alternate implementation, the idea of replacing an *original* method implementation with a *replacement* method implementation is codified in the API with four separate methods.


### With top-level context

```swift
/// To start using the alternate implementation
/// in place of the original:
surrogate.useAlternateImplementation()

/// Code executed here will use *swapped*
/// implementations for the two selectors

/// To restore the original implementation:
surrogate.useOriginalImplementation()

/// Code executed here will use the *original*
/// implementations of the two selectors
```

### With nested context

```swift
/// To automatically gate the replacement and
/// restoration in a single closure:
surrogate.withAlternateImplementation() {
	/// Code executed here will use *swapped*
	/// implementations for the two selectors
}
```

Or while using the alternate implementation:

```swift
surrogate.useAlternateImplementation()

surrogate.withOriginalImplementation() {
	/// Code executed here will use the *original*
	/// implementations of the two selectors
}

surrogate.useOriginalImplementation()
```

### Using any combination safely

```swift
/// Any series and mixture of these methods can
/// be used without methods being swizzled incorrectly
surrogate.withAlternateImplementation() {
	/// Code executed here will use *swapped*
	/// implementations for the two selectors
	
	/// This call will be ignored since the
	/// implementations are already swapped
	self.surrogate.useAlternateImplementation()

	self.surrogate.withOriginalImplementation() 
		/// Code executed here will use the *original*
		/// implementations of the two selectors
	}

	/// Restoring the original implementation for a while
	surrogate.useOriginalImplementation()

	/// Code executed here will use the *original*
	/// implementations of the two selectors

}

/// Even though we didn't explicitly restore
/// the original implementations, they will be
/// restored automatically for us
```
