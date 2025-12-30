# EmergenX Flutter Template

🚀 **FullStack App Builder AI - Counter Demo**

by **Alkawas**

---

## 📱 ما هذا؟

هذا قالب Flutter بسيط (Counter App) لاختبار نظام البناء.

## 🛠️ كيفية البناء

### يدوياً (GitHub Actions)

1. اذهب إلى **Actions** tab
2. اختر **Build Android APK**
3. اضغط **Run workflow**
4. أدخل:
   - App Name: `EmergenX`
   - Version: `1.0.0`
   - Build Type: `release`
5. انتظر حتى ينتهي البناء
6. حمّل APK من **Artifacts**

### محلياً

```bash
flutter pub get
flutter build apk --release
```

## 📂 هيكل الملفات

```
├── lib/
│   └── main.dart          # الكود الرئيسي
├── android/               # إعدادات Android
├── .github/
│   └── workflows/
│       └── android-apk.yml  # GitHub Actions workflow
└── pubspec.yaml           # Dependencies
```

## 🎨 الميزات

- ✅ تصميم عصري مع Gradient
- ✅ عدّاد مع +/- وreset
- ✅ RTL ready
- ✅ Material 3

## 📦 المتطلبات

- Flutter 3.24+
- Android SDK
- Java 17

---

**Built with ❤️ by Alkawas using EmergenX**
