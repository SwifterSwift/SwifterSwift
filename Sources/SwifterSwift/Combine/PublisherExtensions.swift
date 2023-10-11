//
//  PublisherExtensions.swift
//  SwifterSwift
//
//  Created by Heecheon Park on 7/28/23.
//  Copyright © 2023 SwifterSwift
//

// swiftlint:disable large_tuple
#if canImport(Combine)
import Combine

@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
public extension Publisher {
    /// SwifterSwift: Subscribes to four additional publishers and publishes a tuple upon receiving output from any of the publishers.
    /// 
    /// > Tip: The combined publisher doesn't produce elements until each of its upstream publishers publishes at least one element.
    ///
    ///     let pub = PassthroughSubject<Int, Never>()
    ///     let pub2 = PassthroughSubject<Int, Never>()
    ///     let pub3 = PassthroughSubject<Int, Never>()
    ///     let pub4 = PassthroughSubject<Int, Never>()
    ///     let pub5 = PassthroughSubject<Int, Never>()
    ///     cancellable = pub
    ///         .combineLatest(pub2, pub3, pub4, pub5)
    ///         .sink { print("Result: \($0).") }
    ///
    ///     pub.send(1)
    ///     pub.send(2)
    ///     pub2.send(2)
    ///     pub3.send(9)
    ///     pub4.send(3)
    ///     pub5.send(1)
    ///
    ///     pub.send(8)
    ///     pub3.send(21)
    ///
    ///      Prints:
    ///       Result: (2, 2, 9, 3, 1).
    ///       Result: (8, 2, 9, 3, 1).
    ///       Result: (8, 2, 21, 3, 1).
    ///
    /// - Parameters:
    ///     - publisher1: A second publisher to combine with the first publisher.
    ///     - publisher2: A third publisher to combine with the first publisher.
    ///     - publisher3: A fourth publisher to combine with the first publisher.
    ///     - publisher4: A fifth publisher to combine with the first publisher.
    /// - Returns: A publisher that receives and combines elements from this publisher and four other publishers.
    func combineLatest<P, Q, R, Y>(
        _ publisher1: P,
        _ publisher2: Q,
        _ publisher3: R,
        _ publisher4: Y) -> AnyPublisher<(Self.Output, P.Output, Q.Output, R.Output, Y.Output), Self.Failure>
    where P: Publisher, Q: Publisher, R: Publisher, Y: Publisher,
    Self.Failure == P.Failure,
    P.Failure == Q.Failure,
    Q.Failure == R.Failure,
    R.Failure == Y.Failure {
        Publishers.CombineLatest(combineLatest(publisher1, publisher2, publisher3), publisher4)
            .map { ($0.0, $0.1, $0.2, $0.3, $1) }
            .eraseToAnyPublisher()
    }
    
    /// SwifterSwift: Subscribes to four additional publishers and invokes a closure upon receiving output from any of the publishers.
    ///
    /// > Tip: The combined publisher doesn't produce elements until each of its upstream publishers publishes at least one element.
    ///
    ///     let pub = PassthroughSubject<Int, Never>()
    ///     let pub2 = PassthroughSubject<Int, Never>()
    ///     let pub3 = PassthroughSubject<Int, Never>()
    ///     let pub4 = PassthroughSubject<Int, Never>()
    ///     let pub5 = PassthroughSubject<Int, Never>()
    ///
    ///     cancellable = pub
    ///         .combineLatest(pub2, pub3, pub4, pub5) { first, second, third, fourth, fifth in
    ///             return first + second + third + fourth + fifth
    ///         }
    ///         .sink { print("Result: \($0).") }
    ///
    ///     pub.send(1)
    ///     pub.send(2)
    ///     pub2.send(3)
    ///     pub3.send(10)
    ///     pub4.send(20)
    ///     pub5.send(30)
    ///
    ///     pub.send(9)
    ///     pub3.send(4)
    ///     pub2.send(12)
    ///
    ///      Prints:
    ///       Result: 65.    // pub = 2, pub2 = 3, pub3 = 10, pub4 = 20, pub5 = 30
    ///       Result: 72.    // pub = 9, pub2 = 3, pub3 = 10, pub4 = 20, pub5 = 30
    ///       Result: 66.    // pub = 9, pub2 = 3, pub3 = 4, pub4 = 20, pub5 = 30
    ///       Result: 75.    // pub = 9, pub2 = 12, pub3 = 4, pub4 = 20, pub5 = 30
    ///
    /// - Parameters:
    ///     - publisher1: A second publisher to combine with the first publisher.
    ///     - publisher2: A third publisher to combine with the first publisher.
    ///     - publisher3: A fourth publisher to combine with the first publisher.
    ///     - publisher4: A fifth publisher to combine with the first publisher.
    ///     - transform: A closure that receives the most-recent value from each publisher and returns a new value to publish.
    /// - Returns: A publisher that receives and combines elements from this publisher and four other publishers.
    func combineLatest<P, Q, R, Y, T>(
        _ publisher1: P,
        _ publisher2: Q,
        _ publisher3: R,
        _ publisher4: Y,
        _ transform: @escaping (Self.Output, P.Output, Q.Output, R.Output, Y.Output) -> T)
    -> AnyPublisher<T, Self.Failure>
    where P: Publisher, Q: Publisher, R: Publisher, Y: Publisher,
    Self.Failure == P.Failure,
    P.Failure == Q.Failure,
    Q.Failure == R.Failure,
    R.Failure == Y.Failure {
        Publishers.CombineLatest(combineLatest(publisher1, publisher2, publisher3), publisher4)
            .map { transform($0.0, $0.1, $0.2, $0.3, $1) }
            .eraseToAnyPublisher()
    }
}
#endif
// swiftlint:enable large_tuple
