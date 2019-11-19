// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name
internal enum L10n {
  /// Cancel
  internal static let cancel = L10n.tr("Localizable", "cancel")
  /// OK
  internal static let ok = L10n.tr("Localizable", "ok")

  internal enum About {
    /// ⓘ
    internal static let button = L10n.tr("Localizable", "about.button")
    /// About
    internal static let title = L10n.tr("Localizable", "about.title")
  }

  internal enum Delete {
    internal enum Alert {
      /// Are you sure you want to delete «%@ (%@)»?\nThis operation can't be undone
      internal static func message(_ p1: String, _ p2: String) -> String {
        return L10n.tr("Localizable", "delete.alert.message", p1, p2)
      }
      /// Delete this shop
      internal static let title = L10n.tr("Localizable", "delete.alert.title")
    }
  }

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

  internal enum ShopInfo {
    internal enum Details {
      /// Place, additional info…
      internal static let placeholder = L10n.tr("Localizable", "shop_info.details.placeholder")
    }
    internal enum Icon {
      /// 🛒
      internal static let placeholder = L10n.tr("Localizable", "shop_info.icon.placeholder")
    }
    internal enum Name {
      /// Shop name
      internal static let placeholder = L10n.tr("Localizable", "shop_info.name.placeholder")
    }
    internal enum Title {
      /// New shop
      internal static let new = L10n.tr("Localizable", "shop_info.title.new")
      /// Rename shop
      internal static let rename = L10n.tr("Localizable", "shop_info.title.rename")
    }
  }

  internal enum ShopState {
    /// Closed
    internal static let closed = L10n.tr("Localizable", "shop_state.closed")
    /// Closes in %dmn
    internal static func closingSoon(_ p1: Int) -> String {
      return L10n.tr("Localizable", "shop_state.closing_soon", p1)
    }
    /// Reopens at %@
    internal static func nextOpening(_ p1: String) -> String {
      return L10n.tr("Localizable", "shop_state.next_opening", p1)
    }
    /// Open
    internal static let `open` = L10n.tr("Localizable", "shop_state.open")
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
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    // swiftlint:disable:next nslocalizedstring_key
    let format = NSLocalizedString(key, tableName: table, bundle: Bundle(for: BundleToken.self), comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

private final class BundleToken {}
