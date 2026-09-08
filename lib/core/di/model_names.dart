/// Instance names for the AI model registrations declared in
/// `firebase_module.dart`.
///
/// All three are registered as `GenerativeModel`, so get_it cannot tell them
/// apart by type alone. Each registration is given a name here, and each
/// injection site asks for it with `@Named(...)`.
///
/// These live outside the `@module` class on purpose: injectable treats every
/// member of a module as a dependency provider, so a `static const String`
/// declared inside `FirebaseModule` would be registered as a `String`
/// dependency — and two of them would collide.
abstract final class ModelNames {
  static const recipeText = 'recipeText';
  static const imageToIngredients = 'imageToIngredients';
  static const recipeImage = 'recipeImage';
}
