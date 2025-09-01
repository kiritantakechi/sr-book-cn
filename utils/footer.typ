#import "../utils/typography.typ": font-families, font-sizes

#let page-footer(
  twoside: false,
  it,
) = {
  set page(
    numbering: "1",
    footer: context {
      set align(center)
      set text(font: font-families.song, size: font-sizes.size-5)
      set par(leading: 20pt, first-line-indent: 0em)

      counter(page).display()

      block(height: 1fr)
    },
    footer-descent: 1cm,
  )
  counter(page).update(1)

  it
}

#let no-page-footer(body) = {
  set page(footer: none)

  body
}
