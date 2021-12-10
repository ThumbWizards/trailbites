import UIKit

extension UITableViewCell {
    static var defaultReuseIdentifier: String {
        return NSStringFromClass(self)
    }
}
