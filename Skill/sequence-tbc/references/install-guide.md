# Install Guide — ติดตั้งก่อนใช้งาน (ทำครั้งเดียว)

Sequence Diagram ของ TBC เขียนด้วย **PlantUML** ต้องมี 2 อย่างนี้ก่อน

## ✅ สิ่งที่ต้องมี
1. **Java** (PlantUML รันบน Java)
2. **VS Code extension: `jebbs.plantuml`** (ใช้ preview สด + มี plantuml.jar ในตัว)

---

## ขั้นที่ 1 — ติดตั้ง Java

ตรวจก่อนว่ามีหรือยัง:
```bash
java -version
```
- ถ้าขึ้นเลขเวอร์ชัน = มีแล้ว ข้ามไปขั้น 2
- ถ้าไม่มี:
  - **macOS:** `brew install openjdk`  (ถ้ายังไม่มี Homebrew: https://brew.sh)
  - **Windows:** ดาวน์โหลด Temurin JDK จาก https://adoptium.net แล้วติดตั้ง

## ขั้นที่ 2 — ติดตั้ง Extension `jebbs.plantuml`

1. เปิด VS Code → กดแท็บ **Extensions** (`Cmd+Shift+X` / `Ctrl+Shift+X`)
2. ค้นหา **PlantUML** (ผู้พัฒนา **jebbs**)
3. กด **Install**

## ขั้นที่ 3 — Preview สดใน VS Code

1. เปิดไฟล์ `.puml`
2. กด `Option+D` (macOS) หรือ `Alt+D` (Windows) → เปิดหน้าต่าง Preview สด

> หมายเหตุ: Sequence Diagram **ไม่ต้องใช้ Graphviz** (ใช้เฉพาะ diagram บางชนิด เช่น class/activity) จึงข้ามได้

---

## ขั้นที่ 4 — ตรวจว่า render เป็นรูปได้จริง

รันสคริปต์ตรวจสอบนี้ (จะหาตำแหน่ง plantuml.jar ให้อัตโนมัติ):
```bash
JAR="$(ls -1 "$HOME"/.vscode/extensions/jebbs.plantuml-*/plantuml.jar 2>/dev/null | sort -V | tail -n1)"
if [ -n "$JAR" ] && command -v java >/dev/null 2>&1; then
  echo "✅ พร้อมใช้งาน — jar: $JAR"
else
  echo "❌ ยังไม่พร้อม: ตรวจ Java + extension jebbs.plantuml อีกครั้ง"
fi
```
- ขึ้น `✅ พร้อมใช้งาน` = พร้อมไปสร้างไดอะแกรมได้เลย
- ขึ้น `❌` = ย้อนกลับไปทำขั้น 1–2 ใหม่

---

## ปัญหาที่พบบ่อย
| อาการ | สาเหตุ / วิธีแก้ |
|---|---|
| `(Cannot decode ...)` ในรูป | มีการอ้างไฟล์โลโก้ที่ไม่มีอยู่ → ลบ `<img:...>` ออก (โลโก้ปิดเป็น default อยู่แล้ว) |
| ตัวหนังสือไทยเป็นกล่องสี่เหลี่ยม | เครื่องไม่มีฟอนต์ไทย — ติดตั้งฟอนต์ไทย (เช่น Sarabun) แล้ว render ใหม่ |
| `❌ ไม่พบ plantuml.jar` | ยังไม่ได้ติดตั้ง / VS Code ยังไม่ดาวน์โหลด jar เสร็จ — เปิดไฟล์ .puml แล้ว preview 1 ครั้งให้มันโหลด |
