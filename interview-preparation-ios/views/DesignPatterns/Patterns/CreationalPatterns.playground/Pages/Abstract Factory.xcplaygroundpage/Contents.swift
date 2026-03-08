import Foundation

// MARK: - Abstract Factory

// its cdp that helps to produce families of related objects without specifying their concreate classes.

protocol Renderable {
    func render()
}

protocol Button: Renderable {
    func press()
}

protocol Checkbox: Renderable {
    func toggle()
}

class IOSButton: Button {
    func render() {
        print("IOS Button rendered")
    }
    
    func press() {
        print("IOS Button pressed")
    }
}

class IOSCheckbox: Checkbox {
    
    func render() {
        print("IOS Checkbox rendered")
    }
    
    func toggle() {
        print("IOS Checkbox toggled")
    }
}

class MacButton: Button {
    
    func render() {
        print("Mac Button rendered")
    }
    
    func press() {
        print("Mac Button pressed")
    }
}

class MacCheckbox: Checkbox {
    
    func render() {
        print("Mac Checkbox rendered")
    }
    
    func toggle() {
        print("Mac Checkbox toggled")
    }
}

protocol ButtonFactory {
    func makeButton() -> Button
}

protocol CheckboxFactory {
    func makeCheckbox() -> Checkbox
}

protocol GUIFActory: ButtonFactory, CheckboxFactory {}

class IOSFactory: GUIFActory {
    func makeButton() -> Button {
        IOSButton()
    }
    
    func makeCheckbox() -> Checkbox {
        IOSCheckbox()
    }
}

class MacFactory: GUIFActory {
    func makeButton() -> Button {
        MacButton()
    }
    
    func makeCheckbox() -> Checkbox {
        MacCheckbox()
    }
}

enum OS {
    case iOS
    case mac
    
    var factory: GUIFActory {
        switch self {
            case .iOS:
                return IOSFactory()
            case .mac:
                return MacFactory()
        }
    }
}

class Application {
    private let factory: GUIFActory
    private let button: Button
    private let checkbox: Checkbox
    
    init(_ os: OS) {
        factory = os.factory
        button = factory.makeButton()
        checkbox = factory.makeCheckbox()
    }

    func showUI() {
        button.render()
        checkbox.render()
    }
    
    func userInteraction() {
        button.press()
        checkbox.toggle()
    }
}

print("\niOS application")
let iOSApplication = Application(.iOS)
iOSApplication.showUI()
print("\n interactions")
iOSApplication.userInteraction()

print("\nMac Application")
let macApplicaton = Application(.mac)
macApplicaton.showUI()
print("\n interactions")
macApplicaton.userInteraction()

//: [Next](@next)
