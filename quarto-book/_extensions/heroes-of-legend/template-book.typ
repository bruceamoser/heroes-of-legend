// ═══════════════════════════════════════════════════════════════════════════
// Heroes of Legend — Quarto Typst Book Template (Quarto >= 1.10 shim)
//
// WHY THIS FILE EXISTS:
// Quarto 1.10+ renders book projects through the orange-book Typst template,
// whose book() function defaults to paper-size "a4" and its own margins, and
// applies them AFTER include-before-body content — so _quarto.yml `papersize`
// and style.typ's #set page are silently overridden (see orange-book 0.7.1
// lib.typ: book() defaults). This template is a copy of Quarto's own
// template.patched with the book.with() call extended to pass the theme's
// US-Letter geometry explicitly.
//
// Keep in sync with Quarto's template if you upgrade Quarto majors.
// ═══════════════════════════════════════════════════════════════════════════

$numbering.typ()$

$definitions.typ()$

$typst-template.typ()$

$for(header-includes)$
$header-includes$
$endfor$

$page.typ()$

#import "@preview/orange-book:0.7.1": book, part, chapter, appendices

#show: book.with(
  // ── Heroes of Legend geometry (theme overrides) ──────────────────────────
  paper-size: "us-letter",
  margin: (x: 1.15in, top: 0.95in, bottom: 1.0in),
$if(title)$
  title: [$title$],
$endif$
$if(subtitle)$
  subtitle: [$subtitle$],
$endif$
$if(by-author)$
  author: "$for(by-author)$$it.name.literal$$sep$, $endfor$",
$endif$
$if(date)$
  date: "$date$",
$endif$
$if(lang)$
  lang: "$lang$",
$endif$
  main-color: brand-color.at("primary", default: blue),
  logo: {
    let logo-info = brand-logo.at("medium", default: none)
    if logo-info != none { image(logo-info.path, alt: logo-info.at("alt", default: none)) }
  },
$if(toc-depth)$
  outline-depth: $toc-depth$,
$endif$
$if(lof)$
$if(crossref.lof-title)$
  list-of-figure-title: "$crossref.lof-title$",
$else$
$if(quarto.language.crossref-lof-title)$
  list-of-figure-title: "$quarto.language.crossref-lof-title$",
$endif$
$endif$
$endif$
$if(lot)$
$if(crossref.lot-title)$
  list-of-table-title: "$crossref.lot-title$",
$else$
$if(quarto.language.crossref-lot-title)$
  list-of-table-title: "$quarto.language.crossref-lot-title$",
$endif$
$endif$
$endif$
$if(quarto.language.crossref-ch-prefix)$
  supplement-chapter: "$quarto.language.crossref-ch-prefix$",
$endif$
$if(margin-geometry)$
  padded-heading-number: false,
$endif$
)

$if(margin-geometry)$
// Configure marginalia page geometry for book context
// Geometry computed by Quarto's meta.lua filter (typstGeometryFromPaperWidth)
// IMPORTANT: This must come AFTER book.with() to override the book format's margin settings
#import "@preview/marginalia:0.3.1" as marginalia

#show: marginalia.setup.with(
  inner: (
    far: $margin-geometry.inner.far$,
    width: $margin-geometry.inner.width$,
    sep: $margin-geometry.inner.separation$,
  ),
  outer: (
    far: $margin-geometry.outer.far$,
    width: $margin-geometry.outer.width$,
    sep: $margin-geometry.outer.separation$,
  ),
  top: $if(margin.top)$$margin.top$$else$1.25in$endif$,
  bottom: $if(margin.bottom)$$margin.bottom$$else$1.25in$endif$,
  // CRITICAL: Enable book mode for recto/verso awareness
  book: true,
  clearance: $margin-geometry.clearance$,
)
$endif$

$for(include-before)$
$include-before$
$endfor$

$body$

$notes.typ()$

$biblio.typ()$

$for(include-after)$
$include-after$
$endfor$
