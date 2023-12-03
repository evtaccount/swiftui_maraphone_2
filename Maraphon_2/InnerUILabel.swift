//
//  InnerUILabel.swift
//  Maraphon_2
//
//  Created by Evgeny Evtushenko on 03/12/2023.
//

import UIKit
import SwiftUI

struct InnerUILabel: UIViewRepresentable {
    let font: UIFont?
    let color: UIColor
    let lines: Int
    let text: String
    let textAlignment: NSTextAlignment

    @Binding var dynamicHeight: CGFloat

    func makeUIView(context: Context) -> UILabel {
        let lbl = UILabel()
        lbl.text = text
        lbl.font = font
        lbl.textColor = color
        lbl.numberOfLines = lines
        lbl.lineBreakMode = .byWordWrapping
        lbl.textAlignment = textAlignment
        lbl.lineBreakStrategy = .pushOut
        lbl.allowsDefaultTighteningForTruncation = true
        lbl.setContentCompressionResistancePriority(
            .defaultLow,
            for: .horizontal
        )
        lbl.setContentCompressionResistancePriority(
            .defaultLow,
            for: .vertical
        )
        return lbl
    }

    func updateUIView(_ uiView: UILabel, context: Context) {
        DispatchQueue.main.async {
            dynamicHeight = uiView.sizeThatFits(
                CGSize(width: uiView.bounds.width, height: CGFloat.greatestFiniteMagnitude)
            ).height
        }
    }
}

public struct WrappedLabel: View {
    @State private var height: CGFloat = .zero
    let font: UIFont?
    let color: UIColor
    let lines: Int
    let text: String
    let textAlignment: NSTextAlignment
    let redacted: Bool

    public init(
        _ text: String,
        font: UIFont? = .systemFont(ofSize: 15),
        textAlignment: NSTextAlignment = .center,
        color: UIColor = .black,
        redacted: Bool = false,
        lines: Int = 0
    ) {
        self.text = text
        self.textAlignment = textAlignment
        self.font = font
        self.color = color
        self.lines = lines
        self.redacted = redacted
    }

    public var body: some View {
        if redacted {
            Text(text)
                .font(Font(font ?? .systemFont(ofSize: 12)))
                .multilineTextAlignment(textAlignment == .center ? .center : .leading)
                .lineLimit(lines > 0 ? lines : nil)
                .foregroundColor(Color(color))
                .redacted(reason: .placeholder)
        } else {
            InnerUILabel(
                font: font,
                color: color,
                lines: lines,
                text: text,
                textAlignment: textAlignment,
                dynamicHeight: $height
            )
            .frame(minHeight: height)
            .fixedSize(horizontal: false, vertical: true)
        }
    }
}
