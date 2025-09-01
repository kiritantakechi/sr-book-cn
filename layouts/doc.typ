#import "../utils/typography.typ": font-families, font-sizes

#let doc(
  twoside: false,
  info: (:),
  it,
) = {
  set page(
    margin: (top: 3.2cm, bottom: 2.8cm, left: 2.5cm, right: 2.5cm)
  )

  set text(
    hyphenate: false,
    font: font-families.song
  )
  set par(
    leading: 20pt,
    first-line-indent: (amount: 2em, all: true),
  )

  show figure: set align(center)
  show table: set align(center)

  set document(
    author: info.at("author", default: none),
    title: info.at("title", default: none),
  )

  it
}
