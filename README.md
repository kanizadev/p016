# 🎡 Fortune Wheel 

A cute, minimal-yet-polished Flutter fortune wheel with a sage green theme, cute font, glass morphism accents, and a clean “Create Wheel” flow.

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)

## ✨ Features
- Create Wheel page on start (add, remove, reorder slices)
- Sage green theme with Baloo 2 rounded font
- Drag-and-drop slice reordering
- Wheel with gradient rim, triangle indicator, and center badge
- Haptics on spin start and result
- Glassy result banner with copy-to-clipboard
- Debug banner disabled in dev

## 📸 Screenshots

<img src="https://raw.githubusercontent.com/kanizadev/p016/refs/heads/main/1.png" hight=446 width=243 /> <img src="https://raw.githubusercontent.com/kanizadev/p016/refs/heads/main/Fortune%20Wheel%20.gif" hight=446 width=243 /> 

## 🎨 Customization
- Change theme seed color in `MaterialApp.theme` to tweak the palette.
- Adjust slice colors via `_sliceColorFor` (HSV based around hue ~110 for sage).
- Edit fonts in `ThemeData.textTheme` (e.g., Baloo 2, Quicksand, Nunito).

## 🚀 Notes
- The Create screen requires at least 2 non-empty slices before starting.
- Drag handle at the end of each row reorders slices.
- The result banner shows the latest result and lets you copy it.

## ⭐ Show Your Support

Give a ⭐️ if you like this project!



## 📧 Contact

For questions or suggestions, please open an issue on GitHub.

---

Made with Flutter 💙 | Designed with Nature 🌿

