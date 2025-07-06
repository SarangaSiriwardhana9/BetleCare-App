

# BetelCare Flutter App

[![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)](https://dart.dev)
[![Android](https://img.shields.io/badge/Android-3DDC84?style=for-the-badge&logo=android&logoColor=white)](https://android.com)


## 📺 Demo Video

[![Watch the demo](https://img.youtube.com/vi/vjVo22uMZ9g/maxresdefault.jpg)](https://www.youtube.com/watch?v=vjVo22uMZ9g)


## Overview

BetelCare is a comprehensive Flutter mobile application developed as an innovative research project at Sri Lanka Institute of Information Technology (SLIIT). Designed specifically for Sri Lankan betel farmers, this research initiative addresses critical technological gaps in precision agriculture by integrating advanced machine learning capabilities with traditional farming knowledge to provide intelligent agricultural solutions across Kurunegala, Puttalam, and Anamaduwa regions.

This research project represents the first comprehensive AI-powered mobile solution tailored for betel cultivation in Sri Lanka, bridging the divide between conventional agricultural practices and modern data-driven farming methodologies. The application emerges from extensive field research and literature analysis, identifying the unique challenges faced by betel farmers, particularly newcomers to the industry who lack access to modern farming knowledge and technological resources.

The project's core mission focuses on empowering farmers through accessible technology, featuring complete Sinhala language integration to ensure usability across diverse linguistic communities. By combining cutting-edge machine learning algorithms with user-centered design principles, BetelCare transforms complex agricultural predictions into actionable insights that farmers can readily understand and implement for enhanced productivity and sustainability.

## 🌟 Key Features

### 1. Disease Detection System
- **Real-time CNN-based detection** of brown spots, bacterial leaf blight, firefly, and two-spotted red spider mites  
- **Advanced image preprocessing** with segmentation and feature extraction  
- **Rule-based treatment recommendations** with customized application schedules  
- **Geospatial disease mapping** for outbreak tracking and intervention coordination  

### 2. Harvest Prediction Analytics
- **Dual field measurement systems**: GPS perimeter traversal and interactive map-based boundary delineation  
- **Ensemble ML integration** for optimal harvest timing predictions  
- **Multi-type support** for P-Type, KT-Type, and RKT-Type betel leaves  
- **Resource planning tools** with yield comparison capabilities  

### 3. Market Intelligence Platform
- **WhatsApp chatbot integration** (BetelBrio) for market predictions  
- **Multilingual support**: Complete Sinhala, Tamil, and English interfaces  
- **Structured data collection** through conversational workflows  
- **Profitable market recommendations** with location-based insights  

### 4. Weather Advisory Framework
- **Real-time weather integration** with OpenMeteo and Sri Lanka Meteorology APIs  
- **7-day recommendation calendar** for irrigation, fertilization, and protection  
- **Location-specific guidance** tailored to regional conditions  
- **Smart notification system** for timely agricultural activities  

## 🛠️ Technical Architecture
```
├── lib/
│   ├── screens/          # UI screens and pages
│   ├── services/         # API integration and ML model services
│   ├── models/           # Data models and structures
│   ├── widgets/          # Reusable UI components
│   ├── utils/            # Helper functions and utilities
│   └── localization/     # Sinhala language support
├── assets/               # Images, icons, and local assets
├── android/              # Android-specific configurations
└── ios/                  # iOS-specific configurations
```

## 🚀 Installation & Setup

### Prerequisites
- Flutter SDK (3.0+)  
- Dart SDK (3.0+)  
- Android Studio / VS Code  
- Android device or emulator  

### Setup Instructions

1. **Clone the repository**
   ```bash
   git clone https: https://github.com/SarangaSiriwardhana9/BetleCare-App.git
   cd betelcare-flutter
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Configure environment variables**
   ```bash
   # Create .env file in root directory
   cp .env.example .env
   # Add your API keys and configuration
   ```

4. **Run the application**
   ```bash
   flutter run
   ```

## 📱 Core Dependencies
```yaml
dependencies:
  flutter:
    sdk: flutter
  http: ^1.1.0                    # API communication
  geolocator: ^10.1.0            # GPS functionality
  geocoding: ^2.1.1              # Reverse geocoding
  google_maps_flutter: ^2.5.0    # Maps integration
  image_picker: ^1.0.4           # Camera functionality
  supabase_flutter: ^1.10.25     # Database integration
  flutter_localizations:
    sdk: flutter                 # Sinhala support
  provider: ^6.1.1               # State management
  shared_preferences: ^2.2.2     # Local storage
```

## 🌐 API Integration
The app integrates with multiple external services:

- **BetelCare Backend API**: ML model predictions and data processing  
- **OpenMeteo Weather API**: Real-time weather data and forecasting  
- **Google Maps SDK**: Interactive mapping and geolocation services  
- **WhatsApp Business API**: Chatbot integration via 360Dialog  
- **Supabase**: Database operations and real-time data sync  

## 🏗️ Architecture Patterns

- **Provider Pattern**: State management across the application  
- **Repository Pattern**: Data layer abstraction for API calls  
- **Service Layer**: Business logic separation from UI components  
- **Localization**: Complete Sinhala language implementation  

## 🔧 Configuration

### Environment Variables
```
BETELCARE_API_URL=your_backend_api_url
OPENMETEO_API_KEY=your_openmeteo_key
GOOGLE_MAPS_API_KEY=your_google_maps_key
SUPABASE_URL=your_supabase_url
SUPABASE_ANON_KEY=your_supabase_key
```

### Build Configuration
```bash
# Debug build
flutter build apk --debug

# Release build
flutter build apk --release

# Install on device
flutter install
```

## 📊 Performance Optimization

- Image compression for disease detection uploads  
- Caching strategies for weather data and maps  
- Offline capabilities for core functionalities  
- Memory management for ML model inference  

## 🌍 Localization Support

Complete Sinhala language implementation:

- UI text translations  
- Number and date formatting  
- Right-to-left text support where applicable  
- Cultural adaptation for agricultural terminology  

## 🤝 Contributing

1. Fork the repository  
2. Create a feature branch (`git checkout -b feature/new-feature`)  
3. Commit changes (`git commit -am 'Add new feature'`)  
4. Push to branch (`git push origin feature/new-feature`)  
5. Create Pull Request  

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 👥 Research Team

- **Eshan Imesh** - Associate Software Engineer  
- **Saranga Siriwardhana** - Junior Full Stack Developer  
- **Umesh Dewasinghe** - Trainee AI/ML Engineer  
- **Kavindi Fernando** - Trainee Business Analyst  

**Supervisors**:  
- Dr. Sanvitha Kasthuriarachchi - Assistant Professor, SLIIT  
- Ms. Lokesha Weerasinghe - Senior Lecturer, SLIIT  

## 📞 Support

For technical support or questions, please open an issue in this repository or contact the development team.
