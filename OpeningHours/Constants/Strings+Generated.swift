// Generated using SwiftGen, by O.Halligon — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// swiftlint:disable explicit_type_interface identifier_name line_length nesting type_body_length type_name
internal enum L10n {
  /// Cancel
  internal static let cancel = L10n.tr("Localizable", "cancel")
  /// OK
  internal static let ok = L10n.tr("Localizable", "ok")

  internal enum NewTimeRange {
    /// End
    internal static let endTime = L10n.tr("Localizable", "new_time_range.endTime")
    /// Start
    internal static let startTime = L10n.tr("Localizable", "new_time_range.startTime")
    /// New slot
    internal static let title = L10n.tr("Localizable", "new_time_range.title")
    /// Week days
    internal static let weekdays = L10n.tr("Localizable", "new_time_range.weekdays")
  }

  internal enum Shop {

    internal enum New {
      /// New shop
      internal static let defaultName = L10n.tr("Localizable", "shop.new.default_name")

      internal enum Prompt {
        /// Shop name:
        internal static let message = L10n.tr("Localizable", "shop.new.prompt.message")
        /// New shop
        internal static let title = L10n.tr("Localizable", "shop.new.prompt.title")
      }
    }

    internal enum Rename {

      internal enum Prompt {
        /// Shop name:
        internal static let message = L10n.tr("Localizable", "shop.rename.prompt.message")
        /// Modifier
        internal static let title = L10n.tr("Localizable", "shop.rename.prompt.title")
      }
    }

    internal enum State {
      /// Closed
      internal static let closed = L10n.tr("Localizable", "shop.state.closed")
      /// Closes in %d minutes
      internal static func closingSoon(_ p1: Int) -> String {
        return L10n.tr("Localizable", "shop.state.closing_soon", p1)
      }
      /// Reopens at %@
      internal static func nextOpening(_ p1: String) -> String {
        return L10n.tr("Localizable", "shop.state.next_opening", p1)
      }
      /// Open
      internal static let `open` = L10n.tr("Localizable", "shop.state.open")
    }
  }

  internal enum ShopsList {
    /// Delete
    internal static let delete = L10n.tr("Localizable", "shops_list.delete")
    /// Rename
    internal static let rename = L10n.tr("Localizable", "shops_list.rename")
    /// Shop
    internal static let title = L10n.tr("Localizable", "shops_list.title")
  }
}
// swiftlint:enable explicit_type_interface identifier_name line_length nesting type_body_length type_name

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = NSLocalizedString(key, tableName: table, bundle: Bundle(for: BundleToken.self), comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

private final class BundleToken {}
