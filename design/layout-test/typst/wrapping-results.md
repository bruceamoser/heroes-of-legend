# Illustration wrapping: quick check

Issue #1201. Typst 0.15.1 with pinned community package wrap-it 0.1.1.

[Three-page PDF](../artifacts/hol-illustration-wrap.pdf) ·
[Editable source](illustration-wrap.typ)

1. Left square illustration: body text beside it resumes full width below.
2. Right square illustration: the same opening text with four additional
   paragraphs flows beside and beneath it.
3. Precisely positioned square: frame begins at x=330pt, y=245pt on the page.
   Neighboring text has explicitly reserved space; placement does not itself wrap.

All three pages rendered and inspected. Baseline and extended paragraphs were
verified in PDF text extraction on their intended pages. Source rules unchanged.
The sample uses Library artwork cropped to a square, not newly commissioned art.

**Result:** sufficient support for ordinary rectangular book illustrations.
This supports choosing Typst for the HOL workflow. It does not demonstrate
arbitrary silhouette wrapping, complex centered exclusions, or long wrapped
sections across page boundaries. The package controls its paragraph composition;
final spacing and mixed-content behavior need checking in our production styles.

Compile from the repository root:
```sh
typst compile design/layout-test/typst/illustration-wrap.typ design/layout-test/artifacts/hol-illustration-wrap.pdf
```

The first compile downloads the pinned package from the Typst registry.
Fonts and artwork use the preceding comparison fixture.

[Package documentation](https://typst.app/universe/package/wrap-it/)
