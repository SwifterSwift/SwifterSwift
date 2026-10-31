// Sequence+ForEachInParallel.swift - Copyright 2026 SwifterSwift

public extension Sequence where Element: Sendable {
    /// SwifterSwift: Calls the given closure on every element concurrently, and returns once every call has finished.
    ///
    /// Each element gets its own child task in a task group, so the calls can run in parallel and finish in any order.
    /// The sequence itself is iterated on the caller's executor, and only the elements are sent to the child tasks.
    /// Unlike a version built on `DispatchQueue.concurrentPerform`, this doesn't block a thread while it waits, and
    /// it works on every platform that has Swift concurrency. Where only one thread is available, as on WebAssembly,
    /// the calls still interleave at their suspension points but don't run at the same time.
    ///
    /// Cancelling the calling task cancels the child tasks too; `body` can check `Task.isCancelled` to stop early.
    ///
    /// ```swift
    /// await imageURLs.forEachInParallel { url in
    ///     await thumbnailCache.prefetch(url)
    /// }
    /// ```
    ///
    /// - Parameter body: The closure to call with each element.
    /// - Complexity: O(*n*), where *n* is the length of the sequence; one child task is created per element.
    func forEachInParallel(_ body: @escaping @Sendable (Element) async -> Void) async {
        await withTaskGroup(of: Void.self) { group in
            for element in self {
                group.addTask {
                    await body(element)
                }
            }
        }
    }
}
