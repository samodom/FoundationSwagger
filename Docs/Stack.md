Stack
=====

```swift
struct Stack<T> {
    func hasMoreItems() -> Bool
    mutating func push(item: T)
    mutating func pop() -> T
    func peek() -> T?
}
```
