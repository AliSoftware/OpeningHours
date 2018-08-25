// Generated using SwiftGen, by O.Halligon — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// swiftlint:disable explicit_type_interface identifier_name line_length nesting type_body_length type_name
internal enum L10n {
  /// Fermé
  internal static let shopClosed = L10n.tr("Localizable", "shop_closed")
  /// Ferme dans %d minutes
  internal static func shopClosingSoon(_ p1: Int) -> String {
    return L10n.tr("Localizable", "shop_closing_soon", p1)
  }
  /// Enseignes
  internal static let shopListTitle = L10n.tr("Localizable", "shop_list_title")
  /// Ouvert
  internal static let shopOpen = L10n.tr("Localizable", "shop_open")
}
// swiftlint:enable explicit_type_interface identifier_name line_length nesting type_body_length type_name

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = NSLocalizedString(key, tableName: table, bundle: Bundle(for: BundleToken.self), comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

private final class BundleToken {}
