#import "utils/typography.typ": font-families, font-sizes
#import "layouts/doc.typ": doc
#import "layouts/preface.typ": preface
#import "layouts/mainmatter.typ": mainmatter
#import "layouts/appendix.typ": appendix
#import "pages/cover.typ": cover-page
#import "pages/outline.typ": outline-page
#import "pages/comment.typ": comment-page
#import "pages/section.typ": section-page
#import "pages/epilogue.typ": epilogue-page


#let book(
  date: datetime.today(),
  twoside: false,
  info: (:),
) = {
  date = date
  info = (
    (
      author: "示例作者",
      title: "示例题目",
    )
      + info
  )

  (
    date: date,
    twoside: twoside,
    info: info,

    doc: (..args) => {
      doc(
        ..args,
        twoside: twoside,
        info: info + args.named().at("info", default: (:)),
      )
    },

    preface: (..args) => {
      preface(
        ..args,
        twoside: twoside,
      )
    },

    mainmatter: (..args) => {
      mainmatter(
        ..args,
        twoside: twoside,
      )
    },

    appendix: (..args) => {
      appendix(
        ..args,
        twoside: twoside,
      )
    },

    cover: (cover-image: none, rear: false, ..args) => {
        cover-page(
          ..args,
          cover-image: cover-image,
          date: date,
          rear: rear,
          twoside: twoside,
          info: info + args.named().at("info", default: (:)),
        )
    },

    outline: (..args) => {
      outline-page(
        ..args,
        twoside: twoside,
        info: info + args.named().at("info", default: (:)),
      )
    },

    comment: (..args) => {
      comment-page(
        ..args,
        twoside: twoside,
      )
    },

    section: (..args) => {
      section-page(
        ..args,
        twoside: twoside,
      )
    },

    epilogue: (..args) => {
      epilogue-page(
        ..args,
        twoside: twoside,
        info: info + args.named().at("info", default: (:)),
      )
    },
  )
}
