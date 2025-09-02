#import "../utils/typography.typ": font-families, font-sizes

#let page-header(
  twoside: false,
  it,
) = {
  set page(
    header: context {
      set align(center)
      set text(font: font-families.song, size: font-sizes.size-5)
      set par(leading: 20pt, first-line-indent: 0em)

      // line(length: 100%, stroke: 1pt)
      block(height: 1fr)
    },
  )

  it
}

#let no-page-header(body) = {
  set page(header: none)

  body
}
