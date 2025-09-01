#import "../utils/typography.typ": font-families, font-sizes
#import "@preview/numbly:0.1.0": numbly

#let no-numbering-first-heading(body) = {
  show heading.where(level: 1): set align(center)
  show heading: set par(justify: false)
  set heading(numbering: none, supplement: auto, outlined: true)
  counter(heading).update(0)
  show heading.where(level: 1): it => {
    set text(
      font: font-families.hei,
      weight: "regular",
      size: font-sizes.small-size-3,
    )
    set par(
      first-line-indent: 0em,
      leading: 12pt,
    )
    pagebreak()
    v(20pt)
    it.body
    v(20pt)
  }
  body
}

#let main-text-first-heading(
  twoside: false,
  body,
) = {
  show heading.where(level: 1): set align(center)
  set heading(
    numbering: numbly(
      { "第  {1}  章" },
      "{1}.{2} ",
      "{1}.{2}.{3} ",
      "{1}.{2}.{3}.{4} ",
    ),
    outlined: true,
  )
  show heading.where(level: 1): it => {
    set text(
      font: font-families.hei,
      weight: "bold",
      size: font-sizes.small-size-3,
    )
    set par(
      first-line-indent: 0em,
      leading: 12pt,
    )
    pagebreak(
      weak: true,
      to: if twoside {
        "odd"
      },
    )

    v(20pt)
    counter(heading).display() + h(1em) + it.body
    v(20pt)
  }
  body
}

#let appendix-first-heading(
  twoside: false,
  body,
) = {
  show heading.where(level: 1): set align(center)
  set heading(
    numbering: numbly(
      { "附录 {1}" },
      "{1}.{2} ",
      "{1}.{2}.{3} ",
      "{1}.{2}.{3}.{4} ",
    ),
    supplement: [附录],
    outlined: true,
  )
  counter(heading).update(0)
  show heading.where(level: 1): it => {
    set text(
      font: font-families.hei,
      weight: "regular",
      size: font-sizes.small-size-3,
    )
    set par(
      first-line-indent: 0em,
      leading: 10pt,
    )
    pagebreak(
      weak: true,
      to: if twoside {
        "odd"
      },
    )

    v(20pt)
    counter(heading).display() + h(1em) + it.body
    v(20pt)
  }

  show heading.where(level: 2): set heading(outlined: false)
  show heading.where(level: 3): set heading(outlined: false)

  body
}

#let other-heading(
  twoside: false,
  body
) = {
  set heading(outlined: true)

  show heading.where(level: 2): it => {
    set text(
      font: font-families.hei,
      weight: "regular",
      size: font-sizes.size-4,
    )
    set par(
      first-line-indent: 0em,
      leading: 12pt,
    )
    v(12pt)
    counter(heading).display() + h(1em) + it.body
    v(6pt)
  }

  show heading.where(level: 3): it => {
    set text(
      font: font-families.hei,
      weight: "regular",
      size: font-sizes.medium-size-4,
    )
    set par(
      first-line-indent: 0em,
      leading: 12pt,
    )
    v(6pt)
    counter(heading).display() + h(1em) + it.body
    v(6pt)
  }

  body
}
