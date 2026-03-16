# ☕ Coffee Store App (โปรเจกต์สอบปฏิบัติปลายภาค)
**รายวิชา:** ENGSE608 Mobile Devices Application Design and Development
**ผู้พัฒนา:** นายเอกพันธ์ ทศทิศรังสรรค์
**รหัสประจำตัว:** 67543210050-0 (เลขที่ 14)
**Package Name:** com.akkapan.coffeestore

---

## 📱 ภาพรวมแอปพลิเคชัน (Application Overview)
แอปพลิเคชันสำหรับจัดการและบันทึกสูตรเมนูกาแฟ พัฒนาด้วย Flutter โดยเน้นการใช้งานที่ง่าย รวดเร็ว และมีการจัดเก็บข้อมูลแบบ Local Database เพื่อความสะดวกในการใช้งานแบบออฟไลน์

### ฟีเจอร์หลัก (Key Features)
- [x] **Management (CRUD):** เพิ่ม, แสดง, แก้ไข และลบข้อมูลเมนูกาแฟได้สมบูรณ์
- [x] **Search System:** ระบบค้นหาชื่อเมนูแบบ Real-time
- [x] **Statistical Dashboard:** หน้าสรุปผลที่คำนวณจำนวนเมนูทั้งหมด, เมนูพร้อมขาย และราคาเฉลี่ย
- [x] **State Management:** ใช้ Provider ในการแจ้งเตือนและอัปเดตข้อมูลข้ามหน้าจอ
- [x] **Local Database:** ใช้ sqflite เก็บข้อมูลจริงภายในเครื่อง
- [x] **Validation:** ระบบตรวจสอบข้อมูลก่อนบันทึกเพื่อป้องกันค่าว่าง
- [x] **Interactive UI:** มีระบบ Confirmation Dialog ก่อนลบข้อมูล และ SnackBar แจ้งเตือน



## 🏗️ โครงสร้างโปรเจกต์ (Project Structure)
เพื่อให้ง่ายต่อการบำรุงรักษา แอปได้ถูกจัดโครงสร้างแบบแยกส่วน (Clean Architecture):
- `lib/models/`: ไฟล์ `coffee_model.dart` สำหรับนิยามโครงสร้างข้อมูล
- `lib/providers/`: ไฟล์ `coffee_provider.dart` สำหรับจัดการ Logic และ State
- `lib/services/`: ไฟล์ `database_helper.dart` สำหรับเชื่อมต่อ SQLite
- `lib/screens/`: ไฟล์หน้าจอต่างๆ ของแอปพลิเคชัน
- `lib/widgets/`: ไฟล์ชิ้นส่วน UI ที่นำกลับมาใช้ซ้ำได้

---

## 🛠️ เทคโนโลยีและแพลตฟอร์ม (Tech Stack)
- **Framework:** Flutter (Material 3 Design)
- **State Management:** Provider
- **Database:** sqflite (SQLite)
- **Platform:** iOS (ทดสอบบน Simulator iPhone 16e)

---

## 🚀 วิธีการติดตั้งและรันโปรเจกต์
1. Clone โปรเจกต์นี้ลงในเครื่อง
2. รันคำสั่ง `flutter pub get` เพื่อโหลด dependencies
3. รันคำสั่ง `flutter pub run flutter_launcher_icons` เพื่อสร้างไอคอน
4. รันคำสั่ง `flutter run` เพื่อเริ่มใช้งานแอป

---

## 🖼️ ภาพหน้าจอการใช้งาน (Screenshots)

### 1. หน้าจอหลักและระบบค้นหา
| เมนูทั้งหมด | ระบบการค้นหาเมนู | แอพพลิเคชั่นบนหน้าจอ |
|:---:|:---:|:---:|
| ![เมนู](./picture_final_test608/เมนู.png) | ![การค้นหา](./picture_final_test608/การค้นหา.png) | ![หน้าจอ]([./picture_final_test608/แอพพลิเคชั่นบนหน้าจอ.png](https://github.com/AkkapanSE/FINALTEST_ENGSE608/blob/main/flutter_application_1/picture_final_test608/%E0%B9%81%E0%B8%AD%E0%B8%9E%E0%B8%9E%E0%B8%A5%E0%B8%B4%E0%B9%80%E0%B8%84%E0%B8%8A%E0%B8%B1%E0%B9%88%E0%B8%99%E0%B8%9A%E0%B8%99%E0%B8%AB%E0%B8%99%E0%B9%89%E0%B8%B2%E0%B8%88%E0%B8%AD.png?raw=true)) |

### 2. การจัดการข้อมูล (CRUD)
| การเพิ่มเมนูใหม่ | ระบบยืนยันการลบ (1) | ระบบยืนยันการลบ (2) |
|:---:|:---:|:---:|
| ![การเพิ่มเมนู](./picture_final_test608/การเพิ่มเมนู.png) | ![ลบ1](./picture_final_test608/ลบ1.png) | ![ลบ2](./picture_final_test608/ลบ2.png) |

### 3. โครงสร้างโปรเจกต์
| โครงสร้างไฟล์ตามโจทย์กำหนด |
|:---:|
| ![โครงสร้าง](./picture_final_test608/โครงสร้างแอพพลิเคชั่นตามโจทย์.png) |


---
