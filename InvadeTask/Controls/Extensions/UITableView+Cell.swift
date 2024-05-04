//
//  UITableView+Cell.swift
//  InvadeMSTask
//
//  Created by Ahmad on 04/05/2024.
//

import Foundation
import UIKit

extension UITableView {

    func register<T: UITableViewCell>(_: T.Type) {
        let key = String(describing: T.self)
        self.register(UINib(nibName: key, bundle: Bundle.main), forCellReuseIdentifier: key)
    }

    func registerHeaderFooter<T: UIView>(_: T.Type, reuseIdentifier: String? = nil) {
        let key = reuseIdentifier ?? String(describing: T.self)
        self.register(UINib(nibName: key, bundle: Bundle.main), forHeaderFooterViewReuseIdentifier: key)

    }

    func dequeue<T: UITableViewCell>(_: T.Type, for indexPath: IndexPath) -> T {
        guard
            let cell = dequeueReusableCell(withIdentifier: String(describing: T.self),
                                           for: indexPath) as? T
            else { fatalError("Could not deque cell with type \(T.self)") }

        cell.selectionStyle = .none

        return cell
    }

    func dequeueCell(reuseIdentifier identifier: String, for indexPath: IndexPath) -> UITableViewCell {
        return dequeueReusableCell(
            withIdentifier: identifier,
            for: indexPath
        )
    }

}
