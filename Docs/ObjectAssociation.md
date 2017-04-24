Object Association
==================

## Protocol

In order to use instance and class methods instead of free functions for object association, the `AssociatingObject` and `AssociatingClass` protocols provide a simple interface.  Simply extend your class to declare conformance to one or both protocol(s).  Keys are unsafe raw pointers to anything.

```swift
typealias ObjectAssociationKey = UnsafeRawPointer

protocol AssociatingObject: class {
    func associate(
        _: Any,
        with: ObjectAssociationKey,
        usingPolicy: objc_AssociationPolicy = .OBJC_ASSOCIATION_RETAIN_NONATOMIC
    )
    func association(for: ObjectAssociationKey) -> Any?
    func removeAssociation(for: ObjectAssociationKey)
    func removeAllAssociations()
}

protocol AssociatingClass: class {
    static func associate(
        _: Any,
        with: ObjectAssociationKey,
        usingPolicy: objc_AssociationPolicy = .OBJC_ASSOCIATION_RETAIN_NONATOMIC
    )
    static func association(for: ObjectAssociationKey) -> Any?
    static func removeAssociation(for: ObjectAssociationKey)
    static func removeAllAssociations()
}
```

When no policy is provided, the association will be non-atomically retained matching the Swift default for variable declaration and assignment.  Using the assignment policy with a value type will lead to undefined behavior.  Use a retention or copy policy instead.


### Unique association keys

In order to allocate memory with unique content that can be used as an object association key, the `UUIDKeyString` function is provided.  Keys can then be created by a simple wrapping call to the `ObjectAssociationKey` initializer.

> Example:
>
> ```swift
> private let myKeyString = UUIDKeyString()
> let myKey = ObjectAssociationKey(myKeyString)
> ```



### Sample usage:

#### Object

```swift
extension MyClass: AssociatingObject {}

let MyKey = ObjectAssociationKey("Key String")

let myObject = MyClass()
let myData = Thing()

myObject.associate(myData, with: MyKey)

let thing = myObject.association(for: MyKey) as? Thing

myObject.removeAssociation(for: MyKey)
//  or myObject.removeAllAssociations()
```

#### Class

```swift
extension MyClass: AssociatingClass {}

let MyKey = ObjectAssociationKey("Key String")

let myClass = MyClass.self
let myData = Thing()

myClass.associate(myData, with: MyKey)

let thing = myClass.association(for: MyKey) as? Thing

myClass.removeAssociation(for: MyKey)
//  or myClass.removeAllAssociations()
```


## Type-specific accessors

For convenience, several common atomic data types have a convenience accessor for retrieving associations in a typed manner.

```swift
extension AssociatingObject {

	/// For boolean associations
	func booleanAssociation(for: ObjectAssociationKey) -> Bool?

	/// For signed integer associations
	func integerAssociation(for: ObjectAssociationKey) -> Int?

	/// For unsigned integer associations
	func unsignedIntegerAssociation(for: ObjectAssociationKey) -> UInt?

	/// For floating-point associations
	func floatAssociation(for: ObjectAssociationKey) -> Float?

	/// For double-precision floating-point associations
	func doubleAssociation(for: ObjectAssociationKey) -> Double?

	/// For string associations
	func stringAssociation(for: ObjectAssociationKey) -> String?

	/// For URL associations
	func urlAssociation(for: ObjectAssociationKey) -> URL?

}
```

```swift
extension AssociatingClass {

	/// For boolean associations
	static func booleanAssociation(for: ObjectAssociationKey) -> Bool?

	/// For signed integer associations
	static func integerAssociation(for: ObjectAssociationKey) -> Int?

	/// For unsigned integer associations
	static func unsignedIntegerAssociation(for: ObjectAssociationKey) -> UInt?

	/// For floating-point associations
	static func floatAssociation(for: ObjectAssociationKey) -> Float?

	/// For double-precision floating-point associations
	static func doubleAssociation(for: ObjectAssociationKey) -> Double?

	/// For string associations
	static func stringAssociation(for: ObjectAssociationKey) -> String?

	/// For URL associations
	static func urlAssociation(for: ObjectAssociationKey) -> URL?

}
```
