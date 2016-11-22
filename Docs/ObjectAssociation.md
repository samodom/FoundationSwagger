Object Association
==================

## Protocol

In order to use object instance methods instead of functions for object association, the `ObjectAssociating` protocol has been defined to provide a simple interface.  Simply extend your class to declare conformance to the protocol.  Keys are unsafe raw pointers to anything.

```swift
typealias ObjectAssociationKey = UnsafeRawPointer

protocol ObjectAssociating {
    func associate(
        _: Any,
        withKey: ObjectAssociationKey,
        usingPolicy: objc_AssociationPolicy
    )
    func associationForKey(_: ObjectAssociationKey) -> Any?
    func removeAssociationForKey(_: ObjectAssociationKey)
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

myObject.associate(
    myData,
    withKey: MyKey,
    usingPolicy: .OBJC_ASSOCIATION_RETAIN
)

let thing = myObject.associationForKey(MyKey) as? Thing

myObject.removeAssociationForKey(MyKey)
//  or myObject.removeAllAssociations()
```


## Type-specific accessors

For convenience several common atomic data types have pairs of accessors for retrieving associations: one providing purely optional associations and one for retrieving assured values by providing default value associations.

```swift
/// For boolean associations
booleanAssociation(forKey: ObjectAssociationKey) -> Bool?
booleanAssociation(forKey: ObjectAssociationKey, defaultValue: Bool) -> Bool

/// For signed integer associations
integerAssociation(forKey: ObjectAssociationKey) -> Int?
integerAssociation(forKey: ObjectAssociationKey, defaultValue: Int) -> Int

/// For unsigned integer associations
unsignedIntegerAssociation(forKey: ObjectAssociationKey) -> UInt?
unsignedIntegerAssociation(forKey: 
ObjectAssociationKey, defaultValue: UInt) -> UInt

/// For floating-point associations
floatAssociation(forKey: ObjectAssociationKey) -> Float?
floatAssociation(forKey: ObjectAssociationKey, defaultValue: Float) -> Float

/// For double-precision floating-point associations
doubleAssociation(forKey: ObjectAssociationKey) -> Double?
doubleAssociation(forKey: ObjectAssociationKey, defaultValue: Double) -> Double

/// For string associations
stringAssociation(forKey: ObjectAssociationKey) -> String?
stringAssociation(forKey: ObjectAssociationKey, defaultValue: String) -> String

/// For URL associations
urlAssociation(forKey: ObjectAssociationKey) -> URL?
urlAssociation(forKey: ObjectAssociationKey, defaultValue: URL) -> URL
```
