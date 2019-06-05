// Copyright © lalacode.io All rights reserved.

import SwiftUI

enum CKColor: Int {
    case link = 0x3e5ca7
}

extension CKColor {
    var swiftUi: Color {
        return Color(hex: rawValue)
    }
}
