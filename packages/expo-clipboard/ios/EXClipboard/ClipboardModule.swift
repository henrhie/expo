// Copyright 2018-present 650 Industries. All rights reserved.

import ExpoModulesCore

let onClipboardChanged = "onClipboardChanged"

public class ClipboardModule: Module {
  public static func definition() -> ModuleDefinition {
    name("ExpoClipboard")

    method("getStringAsync") { () -> String in
      return UIPasteboard.general.string ?? ""
    }

    method("setStringAsync") { (_, content: String?) in
      UIPasteboard.general.string = content ?? ""
    }

    events(onClipboardChanged)

    event(onClipboardChanged) {
      startObserving {
        NotificationCenter.default.removeObserver(self, name: UIPasteboard.changedNotification, object: nil)
        NotificationCenter.default.addObserver(forName: UIPasteboard.changedNotification, object: nil) { notification in
          self.sendEvent(onClipboardChanged, ["content": UIPasteboard.general.string ?? ""])
        }
      }
      stopObserving {
        NotificationCenter.default.removeObserver(self, name: UIPasteboard.changedNotification, object: nil)
      }
    }
  }
}
