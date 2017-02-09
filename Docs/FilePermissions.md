File Permissions
================

In order to simplify the use of file permissions with Foundation, the `FilePermissions` type has been created as a more usable abstraction for POSIX file permissions.  At this point, only read, write and execute permissions are modeled for the user, group and other classes.

```swift
struct FilePermissions {
    let user: ClassPermissions
    let group: ClassPermissions
    let others: ClassPermissions
    
    var mask: UInt16
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
