# Destructure

The `Destructure` module exposes a single extension on the [`Sequence`](https://developer.apple.com/documentation/swift/sequence) protocol:

```Swift
extension Sequence {
    /// - Returns: A tuple containing the `head` and `tail` elements of this sequence, if the this sequence is not empty. Otherwise, `nil`.
    public var destructured: (Element, AnySequence<Element>)?
}
```

The `destructured` property exposes the `head` `Element` and `tail` `AnySequence<Element>` of a given `Sequence`-conforming type value. This is quite helpful for implementing functional-style recursive algorithms elegantly.

## Example usage

```Swift
let friends = ["Chantel", "Matas", "Shreya", "Krish", "Carol", "Harlow", "Cindy"]

/// Using a variety of techniques, find ways to ruin relationships with the given `friends`.
/// - Returns: An empty array of friends.
func burnBridges <S> (friends: S) -> [String] where S: Sequence, S.Element == String {
    // If there are no longer friends whom you have deserted, your job is done
    guard let (first,rest) = friends.destructured else { return friends }
    // Otherwise, burn bridges with the remaining friends
    return burnBridges(friends: rest)
}
```
