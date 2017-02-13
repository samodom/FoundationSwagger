File Permissions
================

In order to simplify the use of file permissions with Foundation, the `FilePermissions` type has been created as a more usable abstraction for POSIX file permissions.  At this point, only read, write and execute permissions are modeled for the user, group and other classes, but any possible mask can be created with the mask-based initializer.


```swift
typealias FilePermissionsMask = UInt16

struct FilePermissions {
    let user: ClassPermissions
    let group: ClassPermissions
    let others: ClassPermissions
    
    var mask: FilePermissionsMask
    
    init(user: ClassPermissions, group: ClassPermissions, others: ClassPermissions)
    init(mask: FilePermissionsMask)
}

struct ClassPermissions: OptionSet {
    let rawValue: UInt8
    
    static let readable: ClassPermissions
    static let writable: ClassPermissions
    static let executable: ClassPermissions
    
    var isReadable: Bool
    var isWritable: Bool
    var isExecutable: Bool
}
```


### `FileManager` extensions

Since file permissions are retrieved and modified through a dictionary of file attributes, simpler means of permission extraction and modification is enabled by the following methods on `FileManager`:

```swift
permissionsOfItem(atPath: String) throws -> FilePermissions?
setPermissions(_: FilePermissions, ofItemAtPath: String) throws
```
