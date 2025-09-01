#import "../utils/typography.typ": font-families, font-sizes
#import "../utils/footer.typ": page-footer
#import "../utils/header.typ": page-header
#import "../utils/heading.typ": main-text-first-heading, other-heading

#let mainmatter(
  twoside: false,
  body,
) = {
  set par(leading: 12pt, spacing: 12pt)

  show: page-footer.with(
    twoside: twoside,
  )

  show: page-header.with(
    twoside: twoside,
  )
  show: main-text-first-heading.with(
    twoside: twoside,
  )
  show: other-heading

  body
}
