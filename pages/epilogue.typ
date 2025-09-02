#let epilogue-page(
  twoside: false,
  info: (:),
  body,
) = {
  par(first-line-indent: 0pt)[〇 后记 〇]

  v(1em)

  body

  v(1em)

  align(right)[#info.author]

  pagebreak(
    weak: true,
    to: if twoside {
      "odd"
    },
  )
}