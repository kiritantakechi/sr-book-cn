#import "../utils/typography.typ": font-families, font-sizes

#let outline-page(
  twoside: false,
  info: (:),
) = {
  show outline.entry: set block(above: 1em)

  context outline(
    title: [目#h(1em)录],
    target: selector(heading),
    indent: 2.2em,
    depth: 3,
  )

  pagebreak(
    weak: true,
    to: if twoside {
      "odd"
    },
  )
}
