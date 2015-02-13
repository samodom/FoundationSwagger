Object Association
==================

#### Protocol

In order to use object instance methods instead of functions for object association, the `ObjectAssociable` protocol has been defined to provide a simple interface.

```swift
protocol ObjectAssociable {
    func associateKey(key: UnsafePointer<Void>, withObject: AnyObject, policy: ObjectAssociationPolicy)
    func associationForKey(key: UnsafePointer<Void>) -> AnyObject?
    func clearAssociationForKey(key: UnsafePointer<Void>)
    func clearAllAssociations()
}
```


#### Policy enumeration

A convenience enumeration for the association policy options has been added to avoid the clumsy policy constants in Foundation:

```swift
enum ObjectAssociationPolicy: UInt {
    case Assign
    case AtomicRetain
    case NonatomicRetain
    case AtomicCopy
    case NonatomicCopy
}
```

#### Conformance and implementation

Conformance to this protocol has been added to `NSObject` and the simple implementation can be added to any Swift class with the following extension:

```swift
extension MySwiftClass: ObjectAssociable {
    func associateKey(key: UnsafePointer<Void>, withObject association: AnyObject, policy: ObjectAssociationPolicy = .Assign) {
        objc_setAssociatedObject(self, key, association, policy.rawValue)
    }

    func associationForKey(key: UnsafePointer<Void>) -> AnyObject? {
        return objc_getAssociatedObject(self, key)
    }

    func clearAssociationForKey(key: UnsafePointer<Void>) {
        objc_setAssociatedObject(self, key, nil, ObjectAssociationPolicy.Assign.rawValue)
    }

    func clearAllAssociations() {
        objc_removeAssociatedObjects(self)
    }
}
```


Sample usage:
```swift
struct Keys {
    static var Key1 = "Key 1"
    static var Key2 = "Key 2"
}

var myObject = MyClass()
var myData = Thing()
myObject.associateKey(&Keys.Key1, withObject: myData, policy: .AtomicRetain)

let thing = myObject.associationForKey(&Keys.Key1) as! Thing()
myObject.clearAssociationForKey(&Keys.Key1)
//  or myObject.clearAllAssociations()
```
