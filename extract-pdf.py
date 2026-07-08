import pymupdf
import re, os, sys

PDF_PATH = "source-doc/Heros of Legend-Playtest-v15.1.pdf"
OUT_DIR = "source-doc/extracted"
IMG_DIR = "assets/images"

os.makedirs(OUT_DIR, exist_ok=True)
os.makedirs(IMG_DIR, exist_ok=True)

doc = pymupdf.open(PDF_PATH)

# ── Extract images ──────────────────────────────────────────────
img_count = 0
for page_num in range(doc.page_count):
    page = doc[page_num]
    imgs = page.get_images(full=True)
    for img in imgs:
        xref = img[0]
        base = doc.extract_image(xref)
        ext = base["ext"]
        img_count += 1
        fname = f"{IMG_DIR}/page{page_num+1:03d}-img{img_count:03d}.{ext}"
        with open(fname, "wb") as f:
            f.write(base["image"])

print(f"Extracted {img_count} images → {IMG_DIR}/")

# ── Extract text as markdown ───────────────────────────────────
# Detect likely headings (larger font sizes)
def get_font_sizes(page):
    """Return dict mapping text spans to their font size."""
    blocks = page.get_text("dict")["blocks"]
    sizes = {}
    for b in blocks:
        if b["type"] != 0:
            continue
        for line in b["lines"]:
            for span in line["spans"]:
                txt = span["text"].strip()
                if txt:
                    sizes[txt] = span["size"]
    return sizes

md_lines = []
md_lines.append("# Heroes of Legend — Playtest Rulebook\n")
md_lines.append("*Extracted from PDF for reference — ground-up redesign in progress*\n")
md_lines.append("---\n")

for page_num in range(doc.page_count):
    page = doc[page_num]
    text = page.get_text("text")
    
    # Skip empty pages
    if len(text.strip()) < 20:
        md_lines.append(f"\n<!-- Page {page_num+1} — empty -->\n")
        continue
    
    md_lines.append(f"\n<!-- PAGE {page_num+1} -->\n")
    
    # Get structured blocks
    blocks = page.get_text("dict")["blocks"]
    in_table = False
    
    for b in blocks:
        if b["type"] == 1:  # Image block
            continue  # Already extracted
            
        if b["type"] != 0:  # Not text
            continue
            
        block_text = ""
        for line in b["lines"]:
            line_text = " ".join(s["text"] for s in line["spans"])
            block_text += line_text + "\n"
        
        block_text = block_text.strip()
        if not block_text:
            continue
            
        # Skip header/footer artifacts
        if "Heroes of Legend [Play Test]" in block_text or block_text.strip().isdigit():
            continue
        if re.match(r'^Heroes of Legend\s*$', block_text.strip()):
            continue
            
        # Detect headings (short lines, often larger font)
        first_span = b["lines"][0]["spans"][0] if b["lines"] else None
        font_size = first_span["size"] if first_span else 10
        is_bold = bool(first_span["flags"] & 2) if first_span else False
        
        lines = block_text.split("\n")
        
        for line in lines:
            line = line.strip()
            if not line:
                continue
            
            # Detect chapter headings
            if re.match(r'^(Chapter|CHAPTER)\s+\d+', line, re.IGNORECASE):
                md_lines.append(f"\n## {line}\n")
            elif font_size >= 18 and len(line) < 80:
                md_lines.append(f"\n## {line}\n")
            elif font_size >= 14 and len(line) < 80 and is_bold:
                md_lines.append(f"\n### {line}\n")
            elif font_size >= 12 and len(line) < 80 and is_bold:
                md_lines.append(f"\n#### {line}\n")
            else:
                # Check for bullet points
                if line.startswith('•') or line.startswith('-') or line.startswith('·'):
                    md_lines.append(f"- {line.lstrip('•-·').strip()}")
                elif re.match(r'^\d+[.)]\s', line):
                    md_lines.append(f"1. {re.sub(r'^\d+[.)]\s*', '', line)}")
                else:
                    md_lines.append(line)
    
    md_lines.append("")  # Page separator

output_path = f"{OUT_DIR}/playtest.md"
with open(output_path, "w") as f:
    f.write("\n".join(md_lines))

print(f"Markdown: {len(md_lines):,} lines → {output_path}")
print(f"File size: {os.path.getsize(output_path):,} bytes")
