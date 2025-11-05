# Fortune Wheel (Sage Edition)

A cute, minimal-yet-polished Flutter fortune wheel with a sage green theme, cute font, glass morphism accents, and a clean “Create Wheel” flow.

## ✨ Features
- Create Wheel page on start (add, remove, reorder slices)
- Sage green theme with Baloo 2 rounded font
- Drag-and-drop slice reordering
- Wheel with gradient rim, triangle indicator, and center badge
- Haptics on spin start and result
- Glassy result banner with copy-to-clipboard
- Debug banner disabled in dev

## 📸 Screenshots
Add images in this section (e.g., `docs/` folder) and update the paths:

| Create Wheel | Wheel |
| --- | --- |
| ![Create](docs/create.png) | ![Wheel](docs/wheel.png) |

## 🛠️ Setup
1. Install Flutter (3.22+ recommended).
2. Get packages:
   ```bash
   flutter pub get
   ```
3. Run the app:
   ```bash
   flutter run
   ```

## 📦 Dependencies
- flutter_fortune_wheel
- google_fonts

If you don’t have `google_fonts` added yet, include the dependency:
```yaml
# pubspec.yaml (dependencies)
google_fonts: ^6.2.1
```

## 🧩 Project Structure
- `lib/main.dart` – app entry, Create Wheel screen, and Fortune Wheel screen
- Uses Material 3 `ThemeData` with a sage seed color

## 🎨 Customization
- Change theme seed color in `MaterialApp.theme` to tweak the palette.
- Adjust slice colors via `_sliceColorFor` (HSV based around hue ~110 for sage).
- Edit fonts in `ThemeData.textTheme` (e.g., Baloo 2, Quicksand, Nunito).

## 🚀 Notes
- The Create screen requires at least 2 non-empty slices before starting.
- Drag handle at the end of each row reorders slices.
- The result banner shows the latest result and lets you copy it.

## 📝 License
MIT © 2025 YourName
