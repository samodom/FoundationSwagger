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


Compare dates with equality and inequality operators:

```swift
earlier == now  //  false
now == now      //  true
now == later    //  false

earlier < now   //  true
earlier <= now  //  true
earlier > now   //  false
earlier >= now  //  false

later < now     //  false
later <= now    //  false
later > now     //  true
later >= now    //  true

now < now       //  false
now <= now      //  true
now > now       //  false
now >= now      //  true
```


### Date Intervals

Ranges of dates can be created with closed or half-open intervals:

```swift
let upToNow = earlier ... now
let nowOrLater = now ..< later
```

Built-in intervals include:

| Function | Produces Interval |
|:--------:|:-----------------:|
| `NSDate.allOfTime()` | `NSDate.distantPast() ... NSDate.distantFuture()` |
| `NSDate.never()` | `NSDate.distantPast() ..< NSDate.distantPast()` |
| `now.before()` | `NSDate.distantPast() ..< now` |
| `now.after()` | `now ... NSDate.distantFuture()` |
