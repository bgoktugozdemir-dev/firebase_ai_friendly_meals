# Firebase AI Friendly Meals - Flutter

An AI-powered meal preparation app built with Flutter, Firebase AI, and modern architecture patterns. This project is based on the Android architecture from the [Firebase Extended Video Samples](https://github.com/FirebaseExtended/firebase-video-samples/tree/workshop/firebase-ai-logic-android/firebase-ai-friendly-meals/android).

## Features

- 📸 **Image Analysis**: Take photos or select images of food ingredients
- 🤖 **AI-Powered Ingredient Recognition**: Use Gemini to identify ingredients from images
- 🍳 **Recipe Generation**: Generate recipes based on identified ingredients and user notes
- 🎨 **Recipe Image Creation**: Generate professional food photography with Imagen
- 📱 **Modern UI**: Clean, Material 3 design with responsive layout

## Architecture

This Flutter app follows the same architectural patterns as the Android project:

### **Data Layer**
```
lib/data/
├── datasource/
│   └── ai_remote_data_source.dart     # AI API calls (Gemini & Imagen)
├── repository/
│   └── ai_repository.dart             # Repository pattern implementation
└── model/
    ├── recipe.dart                    # Recipe data model
    └── home_view_state.dart           # UI state model
```

### **UI Layer**
```
lib/ui/
└── home/
    ├── home_screen.dart               # Main UI screen
    ├── home_controller.dart           # State management (Riverpod)
    └── home_providers.dart            # Dependency injection providers
```

### **Core Infrastructure**
```
lib/core/
└── dependency_injection/
    └── firebase_ai_module.dart        # DI for Firebase AI models
```

## Android vs Flutter Architecture Comparison

| Component | Android (Kotlin) | Flutter (Dart) |
|-----------|-----------------|----------------|
| **State Management** | `HomeViewModel` + LiveData | `HomeController` + Riverpod |
| **Dependency Injection** | Hilt + `@Inject` | GetIt + Injectable |
| **UI Framework** | Jetpack Compose | Flutter Widgets |
| **AI Integration** | Firebase AI SDK | Firebase AI Dart SDK |
| **Architecture Pattern** | MVVM | MVVM with Riverpod |
| **Data Models** | Data classes | Dart classes with copyWith |
| **Repository Pattern** | `AIRepository` | `AIRepository` |
| **Data Sources** | `AIRemoteDataSource` | `AIRemoteDataSource` |

## Tech Stack

### **Core Framework**
- **Flutter**: Cross-platform UI framework
- **Dart**: Programming language

### **State Management & Architecture**
- **Riverpod**: State management and dependency injection
- **GetIt**: Service locator (secondary DI)
- **Injectable**: Code generation for DI

### **Firebase & AI**
- **Firebase Core**: Firebase initialization
- **Firebase AI**: Gemini and Imagen model access
- **Image Picker**: Camera and gallery integration

### **UI & Design**
- **Material 3**: Modern Material Design
- **Flutter Markdown**: Recipe formatting
- **Cupertino Icons**: iOS-style icons

## Getting Started

### Prerequisites

1. **Flutter SDK** (3.8.1 or later)
2. **Firebase Project** with AI Logic enabled
3. **Firebase AI API access** (Gemini Developer API or Vertex AI)

### Setup

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd firebase_ai_friendly_meals
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Configure Firebase**
   - Add your `google-services.json` (Android) and `GoogleService-Info.plist` (iOS)
   - Enable Firebase AI Logic in your Firebase project
   - Set up API keys for Gemini and Imagen models

4. **Run the app**
   ```bash
   flutter run
   ```

## Project Structure Details

### **Key Components**

#### **AIRemoteDataSource**
Handles direct API calls to Firebase AI services:
- `generateIngredients()`: Multimodal Gemini call with image input
- `generateRecipe()`: Text generation based on ingredients and notes
- `generateRecipeImage()`: Imagen model for recipe photography

#### **AIRepository**
Provides a clean interface for the UI layer, abstracting the data source implementation.

#### **HomeController (StateNotifier)**
Manages the home screen state including:
- Image selection and preview
- Ingredient loading states
- Recipe generation workflow
- Error handling

#### **HomeScreen (UI)**
Responsive UI with sections for:
- Image capture/selection
- Ingredients display
- Notes input
- Recipe generation
- Results display

### **Firebase AI Integration**

The app uses Firebase AI Logic to access:

- **Gemini Models**: For text generation and multimodal analysis
- **Imagen Models**: For high-quality recipe image generation

```dart
// Example Gemini call
final response = await _generativeModel.generateContent([
  Content.text(prompt)
]);

// Example Imagen call
final imageResponse = await _imagenModel.generateImages(prompt);
```

## Development Workflow

### **Code Generation**
Some features require code generation:
```bash
# Generate dependency injection code
flutter packages pub run build_runner build

# Watch for changes during development
flutter packages pub run build_runner watch
```

### **Adding New Features**

1. **Data Layer**: Add methods to `AIRemoteDataSource` and `AIRepository`
2. **State Management**: Update `HomeController` and `HomeViewState`
3. **UI**: Modify `HomeScreen` and add new providers if needed
4. **DI**: Register new dependencies in the appropriate modules

## Comparison with Android Implementation

This Flutter implementation maintains feature parity with the Android version while leveraging Flutter-specific patterns:

### **Similarities**
- ✅ Same AI workflows (ingredient detection → recipe generation → image creation)
- ✅ Repository pattern for data access
- ✅ MVVM architecture with reactive state management
- ✅ Dependency injection throughout
- ✅ Error handling and loading states

### **Flutter-Specific Advantages**
- 🚀 **Cross-platform**: Runs on iOS, Android, Web, and Desktop
- 🎨 **Consistent UI**: Same design across all platforms
- ⚡ **Hot Reload**: Faster development cycle
- 📦 **Single Codebase**: Easier maintenance and feature development

## Next Steps

### **TODO Items**
- [ ] Implement actual Firebase AI API calls (currently placeholders)
- [ ] Add image display and preview functionality
- [ ] Implement error handling and user feedback
- [ ] Add loading indicators and animations
- [ ] Set up proper Firebase configuration
- [ ] Add unit and integration tests
- [ ] Implement offline capabilities
- [ ] Add accessibility features

### **Potential Enhancements**
- 📊 **Analytics**: Track user behavior and AI usage
- 💾 **Local Storage**: Save favorite recipes
- 🔐 **Authentication**: User accounts and cloud sync
- 🌍 **Internationalization**: Multi-language support
- 📱 **Platform-specific features**: iOS Shortcuts, Android Widgets

## Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is part of the Firebase Extended samples and follows the same licensing terms.

---

**Built with ❤️ using Flutter and Firebase AI Logic**
