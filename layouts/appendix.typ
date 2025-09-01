#import "../utils/header.typ": page-header
#import "../utils/heading.typ": appendix-first-heading

#let appendix(
  twoside: false,
  body,
) = {
  set par(leading: 12pt, spacing: 12pt)

  show: page-header.with(twoside: twoside)
  show: appendix-first-heading.with(twoside: twoside)

  body
}
