Dates
=====


### Time interval between dates

Subtract one date from another date to produce the time interval between them:

```swift
let now = NSDate()
let later = now + 1.5
let earlier = now - 2.4

now - earlier   //  yields the interval 2.4
now - later     //  yields the interval -1.5
```


### Date Ranges

Ranges of dates can be created with closed or half-open ranges:

```swift
let upToNow = earlier ... now
let nowOrLater = now ..< later
```

Built-in ranges include:

| Function | Produces Range |
|:--------:|:-----------------:|
| `NSDate.allOfTime()` | `NSDate.distantPast() ... NSDate.distantFuture()` |
| `NSDate.never()` | `NSDate.distantPast() ..< NSDate.distantPast()` |
| `now.before()` | `NSDate.distantPast() ..< now` |
| `now.after()` | `now ... NSDate.distantFuture()` |


### Range Inclusion

Easily check whether or not a date falls within a certain date range:

```swift
let range = now ..< later
now.during(range)     //  true
before.during(range)  //  false
later.during(range)   //  false
```
