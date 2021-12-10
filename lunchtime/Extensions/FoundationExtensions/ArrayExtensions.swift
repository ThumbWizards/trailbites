//
//  ArrayExtensions.swift
//  lunchtime
//
//  Created by Mark Perkins on 12/10/21.
//

import Foundation

extension Array {

    /// Returns the element at the index if it is within bounds, otherwise nil.
    func subscriptSafe(_ index: Int) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
