Dates
=====


### Operators

Add or subtract a time interval to or from a date to produce a new date:

```swift
let now = NSDate()
let later = now + 1.5
let earlier = now - 2.4
```

Subtract one date from another date to produce the time interval between them:

```swift
now - earlier   //  yields the interval 2.4
now - later     //  yields the interval -1.5
```
