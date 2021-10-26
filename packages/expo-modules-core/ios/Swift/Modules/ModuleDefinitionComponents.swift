import UIKit

/**
 Extends all modules with the functions used to build a module definition.
 Unfortunately they need to be scoped here, but hopefully this proposal
 https://github.com/apple/swift-evolution/blob/main/proposals/0289-result-builders.md#builder-scoped-name-lookup
 will be implemented in the future.
 */
extension AnyModule {
  // MARK: - Module name

  /**
   Sets the name of the module that is exported to the JavaScript world.
   */
  public static func name(_ name: String) -> AnyDefinition {
    return ModuleNameDefinition(name: name)
  }

  // MARK: - Constants

  /**
   Definition function setting the module's constants to export.
   */
  public static func constants(_ closure: () -> [String : Any?]) -> AnyDefinition {
    return ConstantsDefinition(constants: closure())
  }

  // MARK: - Methods

  /**
   Factory function for methods without the module instance and arguments.
   */
  public static func method<R>(
    _ name: String,
    _ closure: @escaping () -> R
  ) -> AnyMethod {
    return ConcreteMethod(
      name,
      argTypes: [],
      closure,
      detached: true
    )
  }

  /**
   Factory function for methods without arguments.
   */
  public static func method<R>(
    _ name: String,
    _ closure: @escaping (Self) -> R
  ) -> AnyMethod {
    return ConcreteMethod(
      name,
      argTypes: [],
      closure
    )
  }

  /**
   Factory function for methods with one argument.
   */
  public static func method<R, A0: AnyMethodArgument>(
    _ name: String,
    _ closure: @escaping (Self, A0) -> R
  ) -> AnyMethod {
    return ConcreteMethod(
      name,
      argTypes: [AnyArgumentType(A0.self)],
      closure
    )
  }

  /**
   Factory function for methods with 2 arguments.
   */
  public static func method<R, A0: AnyMethodArgument, A1: AnyMethodArgument>(
    _ name: String,
    _ closure: @escaping (Self, A0, A1) -> R
  ) -> AnyMethod {
    return ConcreteMethod(
      name,
      argTypes: [AnyArgumentType(A0.self), AnyArgumentType(A1.self)],
      closure
    )
  }

  /**
   Factory function for methods with 3 arguments.
   */
  public static func method<R, A0: AnyMethodArgument, A1: AnyMethodArgument, A2: AnyMethodArgument>(
    _ name: String,
    _ closure: @escaping (Self, A0, A1, A2) -> R
  ) -> AnyMethod {
    return ConcreteMethod(
      name,
      argTypes: [AnyArgumentType(A0.self), AnyArgumentType(A1.self), AnyArgumentType(A2.self)],
      closure
    )
  }

  /**
   Factory function for methods with 4 arguments.
   */
  public static func method<R, A0: AnyMethodArgument, A1: AnyMethodArgument, A2: AnyMethodArgument, A3: AnyMethodArgument>(
    _ name: String,
    _ closure: @escaping (Self, A0, A1, A2, A3) -> R
  ) -> AnyMethod {
    return ConcreteMethod(
      name,
      argTypes: [AnyArgumentType(A0.self), AnyArgumentType(A1.self), AnyArgumentType(A2.self), AnyArgumentType(A3.self)],
      closure
    )
  }

  /**
   Factory function for methods with 5 arguments.
   */
  public static func method<R, A0: AnyMethodArgument, A1: AnyMethodArgument, A2: AnyMethodArgument, A3: AnyMethodArgument, A4: AnyMethodArgument>(
    _ name: String,
    _ closure: @escaping (Self, A0, A1, A2, A3, A4) -> R
  ) -> AnyMethod {
    return ConcreteMethod(
      name,
      argTypes: [AnyArgumentType(A0.self), AnyArgumentType(A1.self), AnyArgumentType(A2.self), AnyArgumentType(A3.self), AnyArgumentType(A4.self)],
      closure
    )
  }

  /**
   Factory function for methods with 6 arguments.
   */
  public static func method<R, A0: AnyMethodArgument, A1: AnyMethodArgument, A2: AnyMethodArgument, A3: AnyMethodArgument, A4: AnyMethodArgument, A5: AnyMethodArgument>(
    _ name: String,
    _ closure: @escaping (Self, A0, A1, A2, A3, A4, A5) -> R
  ) -> AnyMethod {
    return ConcreteMethod(
      name,
      argTypes: [AnyArgumentType(A0.self), AnyArgumentType(A1.self), AnyArgumentType(A2.self), AnyArgumentType(A3.self), AnyArgumentType(A4.self), AnyArgumentType(A5.self)],
      closure
    )
  }

  /**
   Factory function for methods with 7 arguments.
   */
  public static func method<R, A0: AnyMethodArgument, A1: AnyMethodArgument, A2: AnyMethodArgument, A3: AnyMethodArgument, A4: AnyMethodArgument, A5: AnyMethodArgument, A6: AnyMethodArgument>(
    _ name: String,
    _ closure: @escaping (Self, A0, A1, A2, A3, A4, A5, A6) -> R
  ) -> AnyMethod {
    return ConcreteMethod(
      name,
      argTypes: [AnyArgumentType(A0.self), AnyArgumentType(A1.self), AnyArgumentType(A2.self), AnyArgumentType(A3.self), AnyArgumentType(A4.self), AnyArgumentType(A5.self), AnyArgumentType(A6.self)],
      closure
    )
  }

  /**
   Factory function for methods with 8 arguments.
   */
  public static func method<R, A0: AnyMethodArgument, A1: AnyMethodArgument, A2: AnyMethodArgument, A3: AnyMethodArgument, A4: AnyMethodArgument, A5: AnyMethodArgument, A6: AnyMethodArgument, A7: AnyMethodArgument>(
    _ name: String,
    _ closure: @escaping (Self, A0, A1, A2, A3, A4, A5, A6, A7) -> R
  ) -> AnyMethod {
    return ConcreteMethod(
      name,
      argTypes: [AnyArgumentType(A0.self), AnyArgumentType(A1.self), AnyArgumentType(A2.self), AnyArgumentType(A3.self), AnyArgumentType(A4.self), AnyArgumentType(A5.self), AnyArgumentType(A6.self), AnyArgumentType(A7.self)],
      closure
    )
  }

  // MARK: - `onCreate`

  /**
   Creates module's lifecycle listener that is called right after module initialization.
   */
  public static func onCreate(_ closure: @escaping () -> Void) -> AnyDefinition {
    return EventListener(.moduleCreate, closure)
  }

  /**
   Creates module's lifecycle listener that is called right after module initialization.
   */
  public static func onCreate(_ closure: @escaping (Self) -> Void) -> AnyDefinition {
    return EventListener(.moduleCreate, closure)
  }

  // MARK: - `onDestroy`

  /**
   Creates module's lifecycle listener that is called when the module is about to be deallocated.
   */
  public static func onDestroy(_ closure: @escaping () -> Void) -> AnyDefinition {
    return EventListener(.moduleDestroy, closure)
  }

  /**
   Creates module's lifecycle listener that is called when the module is about to be deallocated.
   */
  public static func onDestroy(_ closure: @escaping (Self) -> Void) -> AnyDefinition {
    return EventListener(.moduleDestroy, closure)
  }

  // MARK: - `onAppContextDestroys`

  /**
   Creates module's lifecycle listener that is called when the app context owning the module is about to be deallocated.
   */
  public static func onAppContextDestroys(_ closure: @escaping () -> Void) -> AnyDefinition {
    return EventListener(.appContextDestroys, closure)
  }

  /**
   Creates module's lifecycle listener that is called when the app context owning the module is about to be deallocated.
   */
  public static func onAppContextDestroys(_ closure: @escaping (Self) -> Void) -> AnyDefinition {
    return EventListener(.appContextDestroys, closure)
  }

  // MARK: - `onAppEntersForeground`

  /**
   Creates a listener that is called when the app is about to enter the foreground mode.
   */
  public static func onAppEntersForeground(_ closure: @escaping () -> Void) -> AnyDefinition {
    return EventListener(.appEntersForeground, closure)
  }

  /**
   Creates a listener that is called when the app is about to enter the foreground mode.
   */
  public static func onAppEntersForeground(_ closure: @escaping (Self) -> Void) -> AnyDefinition {
    return EventListener(.appEntersForeground, closure)
  }

  // MARK: - `onAppBecomesActive`

  /**
   Creates a listener that is called when the app becomes active again.
   */
  public static func onAppBecomesActive(_ closure: @escaping () -> Void) -> AnyDefinition {
    return EventListener(.appBecomesActive, closure)
  }

  /**
   Creates a listener that is called when the app becomes active again.
   */
  public static func onAppBecomesActive(_ closure: @escaping (Self) -> Void) -> AnyDefinition {
    return EventListener(.appBecomesActive, closure)
  }

  // MARK: - `onAppEntersBackground`

  /**
   Creates a listener that is called when the app enters the background mode.
   */
  public static func onAppEntersBackground(_ closure: @escaping () -> Void) -> AnyDefinition {
    return EventListener(.appEntersBackground, closure)
  }

  /**
   Creates a listener that is called when the app enters the background mode.
   */
  public static func onAppEntersBackground(_ closure: @escaping (Self) -> Void) -> AnyDefinition {
    return EventListener(.appEntersBackground, closure)
  }

  // MARK: - View Manager

  /**
   Creates the view manager definition that scopes other view-related definitions.
   */
  public static func viewManager(@ViewManagerDefinitionBuilder _ closure: @escaping () -> ViewManagerDefinition) -> AnyDefinition {
    return closure()
  }

  /**
   Defines the factory creating a native view when the module is used as a view.
   */
  public static func view(_ closure: @escaping () -> UIView) -> AnyDefinition {
    return ViewFactory(closure)
  }

  /**
   Creates a view prop that defines its name and setter.
   */
  public static func prop<ViewType: UIView, PropType>(_ name: String, _ setter: @escaping (ViewType, PropType) -> Void) -> AnyDefinition {
    return ConcreteViewProp(name, setter)
  }

  /**
   Defines event names that this module can send to JavaScript.
   */
  public static func events(_ names: String...) -> AnyDefinition {
    return EventsDefinition(names: names)
  }

  public static func event(_ name: String) -> EventDefinition {
    return EventDefinition(name: name, definitions: [])
  }

  public static func event(_ name: String, @EventDefinitionBuilder _ body: @escaping () -> [AnyDefinition]) -> EventDefinition {
    return EventDefinition(name: name, definitions: body())
  }

  public static func startObserving(_ body: @escaping () -> AnyMethod) -> AnyMethod {
    return ConcreteMethod("startObserving", argTypes: [], body)
  }

  public static func stopObserving(_ body: @escaping () -> AnyMethod) -> AnyMethod {
    return ConcreteMethod("stopObserving", argTypes: [], body)
  }
}
