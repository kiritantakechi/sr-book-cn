#import "../utils/typography.typ": font-families, font-sizes
#import "../utils/footer.typ": no-page-footer
#import "../utils/header.typ": no-page-header
#import "../utils/heading.typ": no-numbering-first-heading

#let preface(
  twoside: false,
  it,
) = {
  set page(
    margin: (top: 3.2cm, bottom: 2.8cm, left: 2.5cm, right: 2.5cm)
  )

  show: no-page-footer
  show: no-page-header
  show: no-numbering-first-heading

  set text(font: font-families.song, size: font-sizes.small-size-4)
  set par(justify: true, leading: 16pt, spacing: 16pt)

  it
}
