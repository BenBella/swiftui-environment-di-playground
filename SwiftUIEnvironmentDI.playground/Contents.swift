import SwiftUI
import Combine
import PlaygroundSupport

// MARK: - App State

struct AppState: Equatable {}

typealias Store<State> = CurrentValueSubject<State, Never>

// MARK: - DI Container

struct DIContainer: EnvironmentKey {
    
    let appState: Store<AppState>
    let interactors: Interactors
    
    init(appState: Store<AppState>, interactors: Interactors) {
        self.appState = appState
        self.interactors = interactors
    }
    
    init(appState: AppState, interactors: Interactors) {
        self.init(appState: Store<AppState>(appState), interactors: interactors)
    }
    
    static var defaultValue: Self { Self.default }
    
    private static let `default` = Self(appState: AppState(), interactors: .stub)
}

extension DIContainer {
    struct Interactors {
        
        func test() {
            print("Button did tap.")
        }
        
        static var stub: Self {
            .init()
        }
    }
}

extension EnvironmentValues {
    var injected: DIContainer {
        get { self[DIContainer.self] }
        set { self[DIContainer.self] = newValue }
    }
}

// MARK: - Injection in the view hierarchy

extension View {
    
    // Used in Tests where we need to inject manually
    func inject(_ appState: AppState,
                _ interactors: DIContainer.Interactors) -> some View {
        let container = DIContainer(appState: .init(appState),
                                    interactors: interactors)
        return inject(container)
    }
    
    func inject(_ container: DIContainer) -> some View {
        return self
            .environment(\.injected, container)
    }
}

struct ContentView: View {
   
    @Environment(\.injected) private var injected: DIContainer
    
    var body: some View {
        Button(action: {
            injected.interactors.test()
        }) {
            Text("Button")
        }
    }
}

PlaygroundPage.current.setLiveView(ContentView())
