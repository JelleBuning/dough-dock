## Coding Standards
- **Modern Dart:** Use `final`, `const`, type inference, and null safety.
- **Immutability:** Prefer immutable classes and `const` constructors by default.
- **Collections:** Expose `UnmodifiableListView` or `List.unmodifiable` for public APIs.
- **Async:** Avoid blocking calls. Use `Future`, `Stream`, `async`/`await`. Support cancellation with `CancelableOperation` if needed.
- **Guard Clauses:** Validate arguments at the start of methods.

## Architecture & Patterns
- **MVVM:** Use Model-View-ViewModel to separate UI from business logic.
- **Dependency Injection:** Use `Provider` to inject services, repositories, and view models. Keep DI at the top of the widget tree.
- **State Management:** Use `Provider` (or `ChangeNotifier`) for app-wide or feature-specific state. Keep state immutable where possible.
- **Routing:** Use `GoRouter` for navigation. Centralize routes, prefer named routes, and handle deep linking cleanly.
- **Design Patterns:** Apply patterns intentionally (Strategy, Factory, Decorator, etc.).

## Error Handling
- **Results:** Use explicit result types like `Result<T>` or `Either<L, R>` for recoverable errors.
- **Exceptions:** Throw only for truly exceptional cases.

## Performance
- Avoid premature micro-optimizations.
- Use `Iterable`, `Stream`, or `List` efficiently. Use lazy evaluation when possible.
- Prefer `const` and `final` for performance and memory efficiency.
- Minimize rebuilds in widgets by using `Consumer`, `Selector`, or `context.select`.

## Best Practices
- **Code Organization:** Separate features into modules; maintain consistent folder structure (e.g., `models/`, `viewmodels/`, `views/`, `services/`).
- **Testing:** Write unit tests for ViewModels and services, widget tests for UI, mock dependencies with `mockito` or `mocktail`.
- **Documentation:** Document public APIs and complex logic.
- **Linting:** Use `dart analyze` and `flutter_lints`.
- **UI Practices:** Prefer `StatelessWidget` when possible; use `Consumer` and `Selector` to avoid unnecessary rebuilds in `StatefulWidget`.