#import "../utils/typography.typ": font-families, font-sizes
#import "../utils/datetime.typ": datetime-display

#let cover-page(
  cover-image: none,
  date: datetime.today(),
  twoside: false,
  info: (:),
) = {
  align(
    center,
    text(font: font-families.hei, size: font-sizes.small-size-1)[#info.title],
  )

  v(2cm)

  if cover-image != none {
    align(center,image(cover-image, width: 80%))
  }

  v(1fr)

  align(center)[文#h(1em)#info.author]

  v(1cm)

  align(center)[修订日期#h(1em)#datetime-display(date)]

  v(1cm)

  pagebreak(
    weak: true,
    to: if twoside {
      "odd"
    },
  )
}
