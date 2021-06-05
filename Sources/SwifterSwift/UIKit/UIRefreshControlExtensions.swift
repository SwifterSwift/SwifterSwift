// UIRefreshControlExtensions.swift - Copyright 2020 SwifterSwift

#if os(iOS)
import UIKit

// MARK: - Methods

public extension UIRefreshControl {
    /// SwifterSwift: Programmatically begin refresh control inside of UITableView.
    ///
    /// - Parameters:
    ///   - tableView: UITableView instance, inside which the refresh control is contained.
    ///   - animated: Boolean, indicates that is the content offset changing should be animated or not.
    ///   - sendAction: Boolean, indicates that should it fire sendActions method for valueChanged UIControlEvents.
    func beginRefreshing(in tableView: UITableView, animated: Bool, sendAction: Bool = false) {
        // https://stackoverflow.com/questions/14718850/14719658#14719658
        assert(superview == tableView, "Refresh control does not belong to the receiving table view")

        beginRefreshing()
        let offsetPoint = CGPoint(x: 0, y: -frame.height)
        tableView.setContentOffset(offsetPoint, animated: animated)

        if sendAction {
            sendActions(for: .valueChanged)
        }
    }

    /// SwifterSwift: Programmatically begin refresh control inside of UIScrollView.
    ///
    /// - Parameters:
    ///   - animated: Boolean, indicates that is the content offset changing should be animated or not.
    ///   - sendAction: Boolean, indicates that should it fire sendActions method for valueChanged UIControlEvents.
    func beginRefreshing(animated: Bool, sendAction: Bool = false) {
        // https://stackoverflow.com/questions/14718850/14719658#14719658
        guard let scrollView = superview as? UIScrollView else {
            assert(false, "Refresh control does not belong to a scroll view")
            return
        }

        beginRefreshing()
        let offsetPoint = CGPoint(x: 0, y: -frame.height)
        scrollView.setContentOffset(offsetPoint, animated: animated)

        if sendAction {
            sendActions(for: .valueChanged)
        }
    }
}

#endif
