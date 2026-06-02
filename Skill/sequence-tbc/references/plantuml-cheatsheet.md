# PlantUML Cheatsheet — syntax ที่ใช้บ่อย

อ้างอิงเร็วสำหรับ Sequence Diagram (เฉพาะที่ใช้ในกติกา TBC)

## โครงไฟล์
```
@startuml ชื่อไดอะแกรม
... (theme + metadata + flow) ...
@enduml
```

## ผู้เกี่ยวข้อง
```
actor "User\n(ลูกค้า)" as User       ' คน
participant "⚙️ CRM" as CRM           ' ระบบ
```

## ลูกศร / ข้อความ
```
User -> CRM : ส่งคำขอ        ' เส้นทึบ = request
CRM --> User : ตอบกลับ       ' เส้นประ = response
CRM -> CRM : ตรวจสอบภายใน    ' self-message
```
ขึ้นบรรทัดใหม่ในข้อความ: ใช้ `\n`

## เงื่อนไข (ทางแยก)
```
alt เงื่อนไข A
    ...
else เงื่อนไข B
    ...
end
```
ทำเป็นทางเลือกเดียว (ไม่มี else) ใช้ `opt`:
```
opt ถ้ามีคูปอง
    ...
end
```
ทำซ้ำ (loop):
```
loop จนกว่าจะกรอก PIN ถูก
    ...
end
```

## Note (รวม Status)
```
note over User #D4EDDA
  📱 **สถานะ:** "Approved"
  ⚡ **Trigger:** ส่ง LINE แจ้งเตือน
end note

note across #F4F6F8        ' กล่องพาดทุก lifeline (ใช้ทำ legend / ข้อมูลเอกสาร)
  ...
end note
```
สีพื้นหลังในข้อความ (ทำ swatch ใน legend): `<back:#FFF3CD>██</back>`

## แบ่งช่วง / autonumber / activation
```
== ชื่อช่วง ==
autonumber              ' เลขลำดับ step
activate CRM            ' เริ่มแถบ activation
deactivate CRM          ' จบแถบ
```

## Metadata
```
title **ชื่อ Flow**\nคำอธิบาย
header v1.0 | 2026-06-01
footer จัดทำโดย ... · ...
```

## Export (ผ่าน scripts/render.sh)
| ฟอร์แมต | คำสั่ง plantuml | ใช้ทำอะไร |
|---|---|---|
| PNG | `-tpng` | แชร์เร็ว / แปะ chat |
| SVG | `-tsvg` | master คมชัด / ทำ PDF |
| PDF | เปิด SVG ใน browser → Print to PDF | เอกสารทางการ |
