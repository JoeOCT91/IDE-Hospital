// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(OSX)
  import AppKit.NSColor
  internal typealias Color = NSColor
#elseif os(iOS) || os(tvOS) || os(watchOS)
  import UIKit.UIColor
  internal typealias Color = UIColor
#endif

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Colors

// swiftlint:disable identifier_name line_length type_body_length
internal struct ColorName {
  internal let rgbaValue: UInt32
  internal var color: Color { return Color(named: self) }

  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#ffffff"></span>
  /// Alpha: 100% <br/> (0xffffffff)
  internal static let white = ColorName(rgbaValue: 0xffffffff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#707070"></span>
  /// Alpha: 100% <br/> (0x707070ff)
  internal static let brownishGrey = ColorName(rgbaValue: 0x707070ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#001867"></span>
  /// Alpha: 100% <br/> (0x001867ff)
  internal static let darkRoyalBlue = ColorName(rgbaValue: 0x001867ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#0f85b9"></span>
  /// Alpha: 100% <br/> (0x0f85b9ff)
  internal static let niceBlue = ColorName(rgbaValue: 0x0f85b9ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#6f0466"></span>
  /// Alpha: 100% <br/> (0x6f0466ff)
  internal static let richPurple = ColorName(rgbaValue: 0x6f0466ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#6f0466"></span>
  /// Alpha: 100% <br/> (0x6f0466ff)
  internal static let richPurpleTwo = ColorName(rgbaValue: 0x6f0466ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#cccccc"></span>
  /// Alpha: 100% <br/> (0xccccccff)
  internal static let veryLightPink = ColorName(rgbaValue: 0xccccccff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#908c8c"></span>
  /// Alpha: 100% <br/> (0x908c8cff)
  internal static let warmGrey = ColorName(rgbaValue: 0x908c8cff)
}
// swiftlint:enable identifier_name line_length type_body_length

// MARK: - Implementation Details

internal extension Color {
  convenience init(rgbaValue: UInt32) {
    let components = RGBAComponents(rgbaValue: rgbaValue).normalized
    self.init(red: components[0], green: components[1], blue: components[2], alpha: components[3])
  }
}

private struct RGBAComponents {
  let rgbaValue: UInt32

  private var shifts: [UInt32] {
    [
      rgbaValue >> 24, // red
      rgbaValue >> 16, // green
      rgbaValue >> 8,  // blue
      rgbaValue        // alpha
    ]
  }

  private var components: [CGFloat] {
    shifts.map {
      CGFloat($0 & 0xff)
    }
  }

  var normalized: [CGFloat] {
    components.map { $0 / 255.0 }
  }
}

internal extension Color {
  convenience init(named color: ColorName) {
    self.init(rgbaValue: color.rgbaValue)
  }
}
