// Copyright © lalacode.io All rights reserved.

import SwiftUI

struct CKTagView : View {

    let text: String
    let color: CKColor

    var body: some View {
        Text(text)
            .padding(.vertical, 4)
            .padding(.horizontal, 8)
            .background(color.swiftUi)
    }
}

extension CKTagView {
    init(text: String) {
        self.text = text
        self.color = CKColor.link
    }

    func color(_ ckColor: CKColor) -> CKTagView {
        return CKTagView(text: text, color: ckColor)
    }
}

#if DEBUG
struct CKTagView_Previews : PreviewProvider {
    static var previews: some View {
        CKTagView(text: "AMA")
    }
}
#endif
