#let bilingual-bibliography(
  title: "参考文献",
  full: false,
  style: "ieee",
) = {
  set text(lang: "zh")
  bibliography(
    title: title,
    full: full,
    style: style,
  )
}
