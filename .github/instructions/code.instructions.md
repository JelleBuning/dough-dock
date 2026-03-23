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

## UI Consistency
- **Design System First:** Define and reuse a centralized design system (colors, typography, spacing, elevation, border radius). Avoid one-off styling.
- **Theming:** Use `ThemeData` and `ColorScheme` consistently. Avoid hardcoded colors; rely on theme extensions where needed.
- **Reusable Components:** Build and use shared widgets (e.g., buttons, inputs, cards) instead of duplicating UI logic.
- **Element Consistency:** Identical UI elements must behave and appear the same across the app. Titles, buttons, inputs, and layouts should not vary between screens without a clear reason.
- **Cross-Screen Consistency:** Maintain consistency between screens. For example, a page title on screen A must match the same title on screen B if they represent the same context.
- **Spacing & Layout:** Follow a consistent spacing scale (e.g., 4/8/12/16). Use layout widgets (`Padding`, `SizedBox`, `Expanded`) predictably.
- **Typography:** Stick to a defined text scale and styles via `TextTheme`. Avoid inline text styling unless necessary.
- **State Feedback:** Ensure consistent handling of loading, empty, error, and success states across screens.
- **Accessibility:** Respect text scaling, contrast, and semantics. Use `Semantics` and ensure tappable areas meet size guidelines.
- **Platform Adaptation:** Follow platform conventions (Material/Cupertino) where appropriate, while maintaining brand consistency.
- **Animations:** Use subtle, consistent animations (`Animated*` widgets). Avoid excessive or mismatched motion patterns.
- **Responsiveness:** Design for multiple screen sizes. Use `LayoutBuilder`, `MediaQuery`, and breakpoints for adaptive layouts.
- **Input & Forms:** Standardize validation, error messages, and input decoration styles across the app.
- **Consistency Over Cleverness:** Prefer predictable UI behavior over unique or complex interactions unless justified.