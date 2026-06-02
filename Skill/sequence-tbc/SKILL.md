---
name: sequence-tbc
description: >-
  Creates business-readable PlantUML sequence diagrams that follow TBC company
  conventions — Thai-primary labels with English technical terms, color-coded
  "status the user actually sees" notes, standardized metadata (flow name,
  author, date, version), semantic colors, dotted autonumbered steps, and
  activation bars. Each diagram is produced as TWO files: a clean .puml (the
  flow only) plus a separate .md (document info + status legend + narration).
  Walks the user through one-time setup (Java + the jebbs.plantuml VS Code
  extension), interviews them for the flow details, generates the files from the
  company template, and exports crisp PNG / SVG / PDF. Use whenever someone wants
  to create, draw, design, or document a sequence diagram, a flow, or
  "อธิบาย flow ระบบ" — especially for Dev, PM, or BA communication.
when_to_use: Activate when someone asks to create/draw/design/document a sequence diagram or system flow in PlantUML — "เขียน flow", "อธิบาย flow ระบบ", "วาด sequence diagram", login/payment/booking flows for Dev/PM/BA communication. Produces TWO files (clean .puml + separate .md) following TBC conventions (Thai labels, user-visible status notes, semantic colors, dotted autonumber). Skip for architecture diagrams, Mermaid, flowcharts, or ER diagrams (use visual-explainer), and for code with no flow to document.
---

# TBC Sequence Diagram

สร้าง Sequence Diagram มาตรฐานบริษัท ที่ทีม **Business (PM/BA) อ่านเข้าใจ** และทีม **Dev นำไปพัฒนาต่อได้** — เขียนด้วย PlantUML, export เป็น PNG/SVG/PDF คมชัด

## เป้าหมายของไดอะแกรมแบบ TBC

ไดอะแกรมหนึ่งใบต้องตอบ 4 อย่างนี้เสมอ:
1. **นี่คือ Flow เรื่องอะไร** — ชื่อ + ขอบเขต (ผ่าน title + metadata)
2. **ระหว่างทาง User เห็น "สถานะ" อะไรจริง ๆ บนหน้าจอ** และพอสถานะนั้นเกิดขึ้น **ระบบทำอะไรต่อ** (Status + Trigger)
3. **เงื่อนไขระบบ** — ทางแยก/กฎ ที่ทำให้ flow ไปคนละทาง (ผ่าน `alt`)
4. **ใครเป็นคนทำ + เมื่อไหร่ + เวอร์ชันไหน** (metadata + footer)

> นิยามคำศัพท์ทั้งหมดอยู่ใน `../CONTEXT.md` — ใช้คำให้ตรงกันเสมอ

---

## Workflow (ทำตามลำดับนี้)

### ขั้น 0 — ตรวจความพร้อมเครื่อง (ทำครั้งแรกครั้งเดียว)
อ่านและทำตาม **[references/install-guide.md](references/install-guide.md)**:
- ตรวจว่ามี **Java** และ **VS Code extension `jebbs.plantuml`**
- ถ้ายังไม่มี ให้พาผู้ใช้ติดตั้งทีละขั้น แล้วค่อยไปต่อ
- รันคำสั่งตรวจสอบที่ระบุในไฟล์นั้น เพื่อยืนยันว่า render ได้จริง

### ขั้น 1 — สัมภาษณ์ (ถามทีละข้อ อย่ายัดทุกคำถามรวด)
ถามผู้ใช้เพื่อเก็บข้อมูลให้ครบ ก่อนเขียน .puml:
1. **Flow นี้เรื่องอะไร?** (จะกลายเป็น title) + อธิบายสั้น 1 บรรทัด
2. **มีใคร (actor) และระบบใด (participant) เกี่ยวข้องบ้าง?** — actor = คน, participant = ระบบ
3. **จุดเริ่ม (trigger) ของ flow คืออะไร?** (User กดอะไร / เหตุการณ์อะไร)
4. **ขั้นตอนหลักทีละ step** — ใคร → ส่ง/ทำอะไร → ถึงใคร
5. **ระหว่างทาง User เห็นสถานะอะไรบ้าง?** แต่ละสถานะ **ระบบ trigger อะไรต่อ?** (สำคัญที่สุด — ห้ามข้าม)
6. **มีเงื่อนไข/ทางแยกไหน?** (สำเร็จ/ไม่สำเร็จ, มีสิทธิ์/ไม่มีสิทธิ์ ฯลฯ) → จะวาดเป็น `alt`
7. **ผู้จัดทำ + เวอร์ชัน** (วันที่ใช้ของวันนี้อัตโนมัติได้)

ถ้าผู้ใช้ตอบไม่ครบข้อ 5–6 ให้ถามย้ำ เพราะเป็นหัวใจของไดอะแกรมแบบ TBC
(เรื่อง export ยังไม่ต้องถามตอนนี้ — ไปถามหลังผู้ใช้ยืนยันไฟล์แล้วในขั้น 4)

### ขั้น 2 — เขียน 2 ไฟล์: `.puml` (รูป) + `.md` (คำอธิบาย)
**ต้องสร้างคู่กันเสมอ** ชื่อเดียวกัน เช่น `mobile-login-flow.puml` + `mobile-login-flow.md`

**ไฟล์ `.puml` (เฉพาะรูป flow):**
- เริ่มจาก **[templates/sequence-template.puml](templates/sequence-template.puml)** เป็นโครง
- **วางบล็อกธีมจาก [assets/tbc-theme.puml](assets/tbc-theme.puml) ไว้บนสุดของไฟล์เสมอ** (inline — **ห้าม `!include`** เพื่อให้ไฟล์ standalone)
- ทำตามกติกาใน **[references/conventions.md](references/conventions.md)** อย่างเคร่งครัด:
  - Status ของ User = `note over User` พร้อม **สีตามความหมาย** + บรรทัด `⚡ Trigger:`
  - เงื่อนไข = `alt`/`else`
  - มี `autonumber "0."` (เลขมีจุด) + activation bars + title/header/footer
  - **ห้ามใส่** กล่องข้อมูลเอกสาร/Status Legend ในรูป (ไปอยู่ใน .md)

**ไฟล์ `.md` (คำอธิบายแยก):**
- ใช้ **[templates/description-template.md](templates/description-template.md)** เป็นโครง
- ใส่: ข้อมูลเอกสาร (เรื่อง/ระบบ/ขอบเขต) + Status Legend (🟡🟢🔴🔵) + สรุปแต่ละช่วง + เงื่อนไขสำคัญ

- syntax ที่ลืม ดูได้ที่ **[references/plantuml-cheatsheet.md](references/plantuml-cheatsheet.md)**
- ดูตัวอย่างที่ทำครบทุกกติกาได้ที่ **[examples/mobile-login-flow.puml](examples/mobile-login-flow.puml)** + **[examples/mobile-login-flow.md](examples/mobile-login-flow.md)**

### ขั้น 3 — ⭐ ให้ผู้ใช้ยืนยันไฟล์ก่อน (Confirm)
**ห้าม export ทันที** — ต้องให้ผู้ใช้ตรวจและยืนยันเนื้อหาไฟล์ทั้งสองก่อน:
1. แสดงเนื้อหา **ไฟล์ `.puml`** และ **ไฟล์ `.md`** ที่เพิ่งสร้าง ให้ผู้ใช้ดู
   (สรุปสาระสำคัญให้ด้วย เช่น มีกี่ section, status/เงื่อนไขอะไรบ้าง)
2. ถามชัด ๆ ว่า **"ยืนยันไฟล์ทั้งสองนี้ไหม หรืออยากแก้ตรงไหน?"**
3. ถ้าผู้ใช้ขอแก้ → แก้ไฟล์แล้ววนกลับมาให้ยืนยันใหม่
4. **ผ่านขั้นนี้ได้ก็ต่อเมื่อผู้ใช้ยืนยันแล้วเท่านั้น** จึงไปขั้น 4

### ขั้น 4 — ถามรูปแบบ Export แล้วค่อย Render
หลังผู้ใช้ยืนยันไฟล์แล้ว ค่อยถาม: **"อยาก export เป็นอะไร — PNG / SVG / PDF (เลือกได้หลายอย่าง)?"**
แล้วรัน **[scripts/render.sh](scripts/render.sh)** ตามที่เลือก:
```bash
bash scripts/render.sh                 # render ทุกไฟล์ .puml → PNG + SVG ลงโฟลเดอร์ exported/
bash scripts/render.sh myflow.puml     # render เฉพาะไฟล์เดียว
bash scripts/render.sh --pdf myflow.puml  # render แล้วเปิด SVG ใน browser เพื่อ Print to PDF
```
- **PNG** (DPI สูง) = แชร์เร็ว / แปะใน chat
- **SVG** = master คมชัดทุกระดับซูม / ใช้ทำ PDF
- **PDF** = เปิด SVG ใน browser → `Cmd+P` → Save as PDF (vector คมชัด ไม่ต้องลงอะไรเพิ่ม)

### ขั้น 5 — ตรวจงาน
- เปิด PNG/SVG ดูว่า render ออกครบ ไม่มี `(Cannot decode)` (ถ้ามี = มีคนใส่โลโก้ผิด ดู conventions)
- เช็ก checklist ท้าย **[references/conventions.md](references/conventions.md)** ให้ครบทุกข้อ

---

## หลักการสำคัญ (อย่าลืม)
- **1 ไดอะแกรม = 2 ไฟล์** — `.puml` (รูปสะอาด) + `.md` (คำอธิบาย/legend แยก) ห้ามยัดคำอธิบายลงในรูป
- **ไฟล์ต้อง standalone** — ไม่พึ่งไฟล์ภายนอก (ไม่ `!include`, ไม่ฝังโลโก้) เพื่อให้แชร์/ย้ายโฟลเดอร์แล้วไม่พัง
- **ภาษาไทยเป็นหลัก** คงคำเทคนิคเป็นอังกฤษ (OTP, Token, API)
- **Status คือสิ่งที่ User เห็นจริง** ไม่ใช่ค่าใน database
- ถ้าผู้ใช้ยังไม่ติดตั้ง extension อย่าเพิ่งเขียน .puml — พาติดตั้งก่อน
- **อย่า export ก่อนผู้ใช้ยืนยันไฟล์** — ต้องให้ยืนยัน `.puml` + `.md` ก่อน แล้วค่อยถามรูปแบบ export
