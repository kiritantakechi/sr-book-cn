#let section-page(
  twoside: false,
  body,
) = {

  body

  pagebreak(
    weak: true,
    to: if twoside {
      "odd"
    },
  )
}