#!/bin/bash
# ============================================================
#  render.sh — ส่งออกไฟล์ PlantUML (.puml) เป็น PNG + SVG (และเปิดทำ PDF)
#
#  วิธีใช้:
#    bash render.sh                  # render ทุกไฟล์ .puml ในโฟลเดอร์ปัจจุบัน
#    bash render.sh myflow.puml      # render เฉพาะไฟล์เดียว
#    bash render.sh --pdf myflow.puml  # render แล้วเปิด SVG ใน browser เพื่อ Print to PDF
#    bash render.sh --pdf            # render ทุกไฟล์ แล้วเปิดอันแรกใน browser
#
#  ผลลัพธ์อยู่ในโฟลเดอร์ exported/
# ============================================================
set -uo pipefail

OPEN_PDF=0
TARGETS=()
for arg in "$@"; do
  case "$arg" in
    --pdf) OPEN_PDF=1 ;;
    *)     TARGETS+=("$arg") ;;
  esac
done

# ----- หา plantuml.jar จาก VS Code extension jebbs.plantuml -----
JAR="$(ls -1 "$HOME"/.vscode/extensions/jebbs.plantuml-*/plantuml.jar 2>/dev/null | sort -V | tail -n1)"
if [ -z "${JAR:-}" ] || [ ! -f "$JAR" ]; then
  JAR="$(ls -1 "$HOME"/.vscode-server/extensions/jebbs.plantuml-*/plantuml.jar 2>/dev/null | sort -V | tail -n1)"
fi
if [ -z "${JAR:-}" ] || [ ! -f "$JAR" ]; then
  echo "❌ ไม่พบ plantuml.jar — กรุณาติดตั้ง extension 'jebbs.plantuml' ใน VS Code ก่อน"
  echo "   (ดูขั้นตอนใน references/install-guide.md)"
  exit 1
fi
if ! command -v java >/dev/null 2>&1; then
  echo "❌ ไม่พบ Java — กรุณาติดตั้ง Java ก่อน (ดู references/install-guide.md)"
  exit 1
fi

OUT="exported"
mkdir -p "$OUT"

# กันรูปโดนตัด: diagram ยาว ๆ ต้องเพิ่มลิมิตขนาดภาพ (default 4096px เตี้ยเกินไป)
LIMIT="-DPLANTUML_LIMIT_SIZE=16384"

# ----- เลือกไฟล์ที่จะ render -----
if [ "${#TARGETS[@]}" -eq 0 ]; then
  shopt -s nullglob
  TARGETS=( *.puml )
fi
if [ "${#TARGETS[@]}" -eq 0 ]; then
  echo "⚠️  ไม่พบไฟล์ .puml ในโฟลเดอร์นี้"
  exit 1
fi

echo "📦 jar : $JAR"
echo "📂 out : $(pwd)/$OUT"
echo "------------------------------------------"

ok=0
first_svg=""
for f in "${TARGETS[@]}"; do
  [ -f "$f" ] || { echo "⚠️  ไม่พบไฟล์: $f"; continue; }
  msg_png="$(java -jar "$JAR" $LIMIT -tpng -o "$OUT" "$f" 2>&1)"
  msg_svg="$(java -jar "$JAR" $LIMIT -tsvg -o "$OUT" "$f" 2>&1)"
  base="$(basename "${f%.puml}")"
  if [ -z "$msg_png" ] && [ -z "$msg_svg" ]; then
    echo "✅ $f  →  $OUT/$base.png + $OUT/$base.svg"
    ok=$((ok+1))
    [ -z "$first_svg" ] && first_svg="$OUT/$base.svg"
  else
    echo "⚠️  $f -> ${msg_png}${msg_svg}"
  fi
done

echo "------------------------------------------"
echo "เสร็จแล้ว: สำเร็จ $ok ไฟล์ (ดูผลลัพธ์ในโฟลเดอร์ '$OUT')"

# ----- เปิด SVG ใน browser เพื่อทำ PDF -----
if [ "$OPEN_PDF" -eq 1 ] && [ -n "$first_svg" ]; then
  echo ""
  echo "📄 กำลังเปิด $first_svg ใน browser ..."
  echo "   ทำ PDF: กด  Cmd+P  →  เลือก 'Save as PDF'  (ได้ PDF แบบ vector คมชัด)"
  if command -v open >/dev/null 2>&1; then
    open "$first_svg"            # macOS
  elif command -v xdg-open >/dev/null 2>&1; then
    xdg-open "$first_svg"        # Linux
  else
    echo "   (เปิดไฟล์ $first_svg ด้วย browser เองได้เลย)"
  fi
fi
