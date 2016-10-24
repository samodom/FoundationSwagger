Object Association
==================

## Protocol

In order to use object instance methods instead of functions for object association, the `ObjectAssociating` protocol has been defined to provide a simple interface.  Simply extend your class to declare conformance to the protocol.

```swift
protocol ObjectAssociating {
    func associate(
        _: Any,
        withKey: UnsafeRawPointer,
        usingPolicy: objc_AssociationPolicy
    )
    func associationForKey(_: UnsafeRawPointer) -> Any?
    func removeAssociationForKey(_: UnsafeRawPointer)
    func removeAllAssociations()
}
```

When no policy is provided, the association will be non-atomically retained matching the Swift default for variable declaration and assignment.  Using the assignment policy with a value type will lead to undefined behavior.  Use a retention or copy policy instead.


### Sample usage:

```swift
extension MyClass: ObjectAssociating {}

let MyKey = UnsafePointer("Key String")

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
