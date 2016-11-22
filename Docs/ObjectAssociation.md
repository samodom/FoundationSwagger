Object Association
==================

## Protocol

In order to use object instance methods instead of functions for object association, the `ObjectAssociating` protocol has been defined to provide a simple interface.  Simply extend your class to declare conformance to the protocol.  Keys are unsafe raw pointers to anything.

```swift
typealias ObjectAssociationKey = UnsafeRawPointer

protocol ObjectAssociating {
    func associate(
        _: Any,
        with: ObjectAssociationKey,
        usingPolicy: objc_AssociationPolicy
    )
    func association(for: ObjectAssociationKey) -> Any?
    func removeAssociation(for: ObjectAssociationKey)
    func removeAllAssociations()
}
```

When no policy is provided, the association will be non-atomically retained matching the Swift default for variable declaration and assignment.  Using the assignment policy with a value type will lead to undefined behavior.  Use a retention or copy policy instead.


### Sample usage:

```swift
extension MyClass: ObjectAssociating {}

let MyKey = ObjectAssociationKey("Key String")

let myObject = MyClass()
let myData = Thing()

myObject.associate(myData, with: MyKey, usingPolicy: .OBJC_ASSOCIATION_RETAIN)

let thing = myObject.association(for: MyKey) as? Thing

myObject.removeAssociation(for: MyKey)
//  or myObject.removeAllAssociations()
```


## Type-specific accessors

For convenience several common atomic data types have pairs of accessors for retrieving associations: one providing purely optional associations and one for retrieving assured values by providing default value associations.

```swift
/// For boolean associations
booleanAssociation(for: ObjectAssociationKey) -> Bool?
booleanAssociation(for: ObjectAssociationKey, defaultValue: Bool) -> Bool

/// For signed integer associations
integerAssociation(for: ObjectAssociationKey) -> Int?
integerAssociation(for: ObjectAssociationKey, defaultValue: Int) -> Int

/// For unsigned integer associations
unsignedIntegerAssociation(for: ObjectAssociationKey) -> UInt?
unsignedIntegerAssociation(for: 
ObjectAssociationKey, defaultValue: UInt) -> UInt

/// For floating-point associations
floatAssociation(for: ObjectAssociationKey) -> Float?
floatAssociation(for: ObjectAssociationKey, defaultValue: Float) -> Float

/// For double-precision floating-point associations
doubleAssociation(for: ObjectAssociationKey) -> Double?
doubleAssociation(for: ObjectAssociationKey, defaultValue: Double) -> Double

/// For string associations
stringAssociation(for: ObjectAssociationKey) -> String?
stringAssociation(for: ObjectAssociationKey, defaultValue: String) -> String

/// For URL associations
urlAssociation(for: ObjectAssociationKey) -> URL?
urlAssociation(for: ObjectAssociationKey, defaultValue: URL) -> URL
```
