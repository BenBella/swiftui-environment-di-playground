# Dependency Injection 

Dependency Injection is a software design pattern in which an object receives other instances that it depends on. It’s a commonly used technique that allows reusing code, insert mocked data, and simplify testing. An example could be initializing a view with the network provider as a dependency.


## Implementation key features

* Usable only for **SwiftUI** based apps.
* **Custom Environment keys** 
* By using **@Environment** property wrapper
* Possibility to override dependencies for tests
* Without **3rd party library**

## Environment

SwiftUI uses `Environment` to pass system-wide settings like `ContentSizeCategory`, `LayoutDirection`, `ColorScheme`, etc. `Environment` also contains app-specific stuff like `UndoManager` and `NSManagedObjectContext`. Full list of the passed values you can find in `EnvironmentValues` struct documentation. Let’s take a look at an example where we access Environment values.

The significant benefit of using Environment and not passing `ObservableObject` via the init method of the view is the internal SwiftUI storage. SwiftUI stores Environment in 
the special framework memory outside the view. It gives an implicit access to view-specific Environment for all child views.

## EnvironmentObject

SwiftUI gives us both `@Environment` and `@EnvironmentObject` property wrappers, but they are subtly different: whereas `@EnvironmentObject` allows us to inject arbitrary values into the environment, `@Environment` is specifically there to work with SwiftUI's own pre-defined keys. `@Environment` is value type but `@EnvironmentObject` is reference type.
