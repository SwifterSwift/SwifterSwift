// BinaryInteger+IsPrimeTests.swift - Copyright 2026 SwifterSwift

import SwifterSwiftStdlib
import Testing

struct BinaryIntegerIsPrimeTests {
    @Test(arguments: [2, 3, 5, 7, 19, 577, 1999, 7919, 1_000_003, 2_147_483_647])
    func returnsTrueForPrimes(value: Int) {
        #expect(value.isPrime)
    }

    // `Int64` rather than `Int`, because `Int` is 32 bits on Apple Watch hardware.
    @Test(arguments: [4, 9, 21, 25, 49, 81, 121, 9409, 1_000_001, 2_147_483_649] as [Int64])
    func returnsFalseForCompositeNumbers(value: Int64) {
        #expect(!value.isPrime)
    }

    @Test(arguments: [0, 1, -1, -2, -7, Int.min])
    func returnsFalseForNumbersBelowTwo(value: Int) {
        #expect(!value.isPrime)
    }

    @Test
    func handlesMaxValuesWithoutOverflowing() {
        #expect(Int8.max.isPrime)  // 127
        #expect(!Int64.max.isPrime)  // 7 × 7 × 73 × 127 × 337 × 92737 × 649657
        #expect(Int32.max.isPrime)  // 2³¹ − 1, a Mersenne prime
        #expect(!UInt64.max.isPrime)  // 3 × 5 × 17 × 257 × 641 × 65537 × 6700417
        #expect(UInt32(4_294_967_291).isPrime)  // the largest prime below 2³²
        #expect(!UInt8.max.isPrime)  // 3 × 5 × 17
        #expect(UInt8(251).isPrime)
    }

    @Test
    func matchesASieveOfEratosthenes() {
        let limit = 10_000
        var sieve = Array(repeating: true, count: limit)
        sieve[0] = false
        sieve[1] = false
        for number in 2..<limit where sieve[number] {
            for multiple in stride(from: number * number, to: limit, by: number) {
                sieve[multiple] = false
            }
        }
        for number in 0..<limit {
            #expect(number.isPrime == sieve[number])
            #expect(UInt16(number).isPrime == sieve[number])
        }
    }

    @Test
    func checksEveryValueOfSmallTypes() {
        let primesBelow128: Set<Int8> = [
            2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97, 101, 103,
            107, 109, 113, 127
        ]
        for value in Int8.min...Int8.max {
            #expect(value.isPrime == primesBelow128.contains(value))
        }
    }
}
