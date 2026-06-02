# Claude Code Skills

รวม Claude Code skills ที่ทำไว้ใช้เอง/แชร์ต่อ skill แต่ละตัวอยู่ในโฟลเดอร์ `Skill/`

## Skills in Repo
| Skill | ทำอะไร |
|---|---|
| [`Skill/sequence-tbc/`](./Skill/sequence-tbc) | วาด Sequence Diagram ให้ Business อ่านเข้าใจ ด้วย PlantUML — ป้ายบอกสถานะที่ User เห็นจริง, สีสื่อความหมาย, เลขลำดับ, export PNG/SVG/PDF เรียกด้วย `/sequence-tbc` |

## วิธีติดตั้ง (ตัวอย่าง sequence-tbc)
```bash
# clone Repoไว้ที่ใดที่หนึ่ง
git clone https://github.com/Suppawit-biz/Claude-Skills.git ~/claude-skills

# แล้ว link โฟลเดอร์ skill เข้าไปใน Claude Code
ln -s ~/claude-skills/Skill/sequence-tbc ~/.claude/skills/sequence-tbc

# อัปเดตภายหลัง
cd ~/claude-skills && git pull
```
หรือ **Download ZIP** แล้วคัดลอกโฟลเดอร์ `Skill/sequence-tbc` ไปไว้ที่ `~/.claude/skills/sequence-tbc/`

จากนั้นพิมพ์ `/sequence-tbc` ใน Claude Code ได้เลย
(รายละเอียดการใช้งานแต่ละ skill อ่านใน README ของ skill นั้น ๆ)
