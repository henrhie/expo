// Copyright 2018-present 650 Industries. All rights reserved.

public struct EventDefinition: AnyDefinition {
  let name: String
  let onStartObserving: AnyMethod?
  let onStopObserving: AnyMethod?

  init(name: String, definitions: [AnyDefinition]) {
    self.name = name

    self.onStartObserving = definitions
      .compactMap { $0 as? AnyMethod }
      .last { $0.name == "startObserving" }

    self.onStopObserving = definitions
      .compactMap { $0 as? AnyMethod }
      .last { $0.name == "stopObserving" }
  }
}


@resultBuilder
public struct EventDefinitionBuilder {
  public static func buildBlock(_ components: AnyDefinition...) -> [AnyDefinition] {
    return components
  }
}
