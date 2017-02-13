Object Association
==================

## Protocol

In order to use instance and class methods instead of free functions for object association, the `AssociatingObject` and `AssociatingClass` protocols provide a simple interface.  Simply extend your class to declare conformance to on or both of the protocols.  Keys are unsafe raw pointers to anything.

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
