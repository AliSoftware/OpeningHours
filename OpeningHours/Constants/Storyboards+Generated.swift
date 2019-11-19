// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

// swiftlint:disable sorted_imports
import Foundation
import UIKit

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Storyboard Scenes

// swiftlint:disable explicit_type_interface identifier_name line_length type_body_length type_name
internal enum StoryboardScene {
  internal enum LaunchScreen: StoryboardType {
    internal static let storyboardName = "LaunchScreen"

    internal static let initialScene = InitialSceneType<UIKit.UIViewController>(storyboard: LaunchScreen.self)
  }
  internal enum Main: StoryboardType {
    internal static let storyboardName = "Main"

    internal static let about = SceneType<UIKit.UIViewController>(storyboard: Main.self, identifier: "About")

    internal static let newTimeRangeViewController = SceneType<OpeningHours.NewTimeRangeViewController>(storyboard: Main.self, identifier: "NewTimeRangeViewController")

    internal static let shopDetails = SceneType<OpeningHours.ShopDetailsContainerViewController>(storyboard: Main.self, identifier: "ShopDetails")

    internal static let shopInfoViewController = SceneType<OpeningHours.ShopInfoViewController>(storyboard: Main.self, identifier: "ShopInfoViewController")

    internal static let shopsList = SceneType<OpeningHours.ShopsListViewController>(storyboard: Main.self, identifier: "ShopsList")

    internal static let timeList = SceneType<OpeningHours.TimeListViewController>(storyboard: Main.self, identifier: "TimeList")

    internal static let timeTable = SceneType<OpeningHours.TimeTableViewController>(storyboard: Main.self, identifier: "TimeTable")
  }
}
// swiftlint:enable explicit_type_interface identifier_name line_length type_body_length type_name

// MARK: - Implementation Details

internal protocol StoryboardType {
  static var storyboardName: String { get }
}

internal extension StoryboardType {
  static var storyboard: UIStoryboard {
    let name = self.storyboardName
    return UIStoryboard(name: name, bundle: Bundle(for: BundleToken.self))
  }
}

internal struct SceneType<T: UIViewController> {
  internal let storyboard: StoryboardType.Type
  internal let identifier: String

  internal func instantiate() -> T {
    let identifier = self.identifier
    guard let controller = storyboard.storyboard.instantiateViewController(withIdentifier: identifier) as? T else {
      fatalError("ViewController '\(identifier)' is not of the expected class \(T.self).")
    }
    return controller
  }
}

internal struct InitialSceneType<T: UIViewController> {
  internal let storyboard: StoryboardType.Type

  internal func instantiate() -> T {
    guard let controller = storyboard.storyboard.instantiateInitialViewController() as? T else {
      fatalError("ViewController is not of the expected class \(T.self).")
    }
    return controller
  }
}

private final class BundleToken {}
