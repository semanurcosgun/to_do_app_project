import 'package:flutter/material.dart';

class Constants {
  static const Color pastelPink = Color(0xFFFBE7F0);

  static const Color pastelPurple = Color(0xFFF3EDFF);

  static const Color pastelCream = Color(0xFFFFF1DE);

  static const Color pastelGreen = Color(0xFFF7F9EE);

  static const Color darkText = Color(0xFF5D4054);

  static const Color primaryPink = Color(0xFFDDA8C8);
  static TextStyle getTitleTextStyle() {
    return TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontFamily: "PinyonScript",
      fontSize: 24,
    );
  }

  static TextStyle completedTaskTextStyle() {
    return TextStyle(
      decoration: TextDecoration.lineThrough,
      color: Colors.grey,
      fontFamily: "PinyonScript",
    );
  }

  static TextStyle taskTimeTextStyle() {
    return TextStyle(
      fontSize: 14,
      color: Colors.grey,
      fontFamily: "PinyonScript",
    );
  }

  static TextStyle taskTextStyle() {
    return TextStyle(
      fontSize: 16,
      color: Colors.black,
      fontFamily: "PinyonScript",
    );
  }

  static TextStyle appBarTextStyle() {
    return TextStyle(
      fontSize: 24,
      color: Colors.black,
      fontFamily: "PinyonScript",
    );
  }

  static String capitalizeWords(String text) {
    return text
        .split(' ')
        .map((word) {
          if (word.isEmpty) return word;

          return word[0].toUpperCase() + word.substring(1).toLowerCase();
        })
        .join(' ');
  }
  // Görev adı (Ders Çalış)
static TextStyle taskDetailTitleStyle() {
  return const TextStyle(
    fontFamily: 'PinyonScript',
    fontSize: 30,
    fontWeight: FontWeight.normal,
    color: darkText,
  );
}

// Görev Bilgileri başlığı
static TextStyle sectionTitleStyle() {
  return const TextStyle(
    fontFamily: 'PinyonScript',
    fontSize: 28,
    fontWeight: FontWeight.normal,
    color: darkText,
  );
}

// Tamamlandı / Yapılacak
static TextStyle taskStatusStyle(bool isCompleted) {
  return TextStyle(
    fontFamily: 'PinyonScript',
    fontSize: 23,
    color: isCompleted ? Colors.green : Colors.orange,
  );
}

// Oluşturulma Tarihi / Saat
static TextStyle infoTitleStyle() {
  return const TextStyle(
    fontFamily: 'PinyonScript',
    fontSize: 23,
    fontWeight: FontWeight.normal,
    color: darkText,
  );
}

// Tarih ve saat değerleri
static TextStyle infoTextStyle() {
  return const TextStyle(
    fontFamily: 'PinyonScript',
    fontSize: 24,
    fontWeight: FontWeight.normal,
    color: darkText,
  );
}

// Görevi Tamamla butonu
static TextStyle detailButtonTextStyle() {
  return const TextStyle(
    fontFamily: 'PinyonScript',
    fontSize: 24,
    fontWeight: FontWeight.normal,
    color: Colors.white,
  );
}
static TextStyle taskListStatusStyle(bool isCompleted) {
  return TextStyle(
    fontFamily: 'PinyonScript',
    fontSize: 22,
    fontWeight: FontWeight.normal,
    color: isCompleted ? Colors.green : Colors.red,
  );
}

}
