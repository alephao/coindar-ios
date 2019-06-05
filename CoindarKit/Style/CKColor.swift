// Copyright © lalacode.io All rights reserved.

import SwiftUI

public enum CKColor: Int {
    case link = 0x3e5ca7
}

extension CKColor {
    public var swiftUi: Color {
        return Color(hex: rawValue)
    }

    public var uiKit: UIColor {
        return UIColor(hex: rawValue)
    }
}
