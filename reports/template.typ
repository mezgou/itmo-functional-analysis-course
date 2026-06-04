// Shared research-report template (Typst 0.14+)

#let report(
  title: "",
  subtitle: "",
  work-number: "",
  author: "",
  group: "",
  reviewer: "",
  city: "Санкт-Петербург",
  body,
) = {
  set text(lang: "ru", region: "RU", font: "Libertinus Serif", size: 12pt)
  set page(paper: "a4", margin: (x: 2.2cm, y: 2.2cm))
  set heading(numbering: "1.1")
  set math.equation(numbering: "(1)", supplement: none)

  show heading: it => block(above: 1.4em, below: 0.9em)[#it]
  show heading.where(level: 1): set text(size: 15pt)
  show heading.where(level: 2): set text(size: 13pt)
  show link: set text(fill: rgb("#1f4e79"))

  // Localized supplements and a clean caption style
  show figure.where(kind: image): set figure(supplement: [Рис.])
  show figure.where(kind: table): set figure(supplement: [Табл.])
  show figure.caption: set text(size: 10pt)
  set figure.caption(separator: [. ])
  set table(stroke: 0.5pt + luma(130), inset: 7pt)

  // Title page
  {
    set page(numbering: none)
    set par(justify: false)
    set text(hyphenate: false)
    align(center)[
      #text(weight: "bold")[
        МИНИСТЕРСТВО НАУКИ И ВЫСШЕГО ОБРАЗОВАНИЯ РОССИЙСКОЙ ФЕДЕРАЦИИ
      ]
      #v(0.2cm)
      #text(weight: "bold")[
        ФЕДЕРАЛЬНОЕ ГОСУДАРСТВЕННОЕ АВТОНОМНОЕ ОБРАЗОВАТЕЛЬНОЕ УЧРЕЖДЕНИЕ \
        ВЫСШЕГО ОБРАЗОВАНИЯ \
        «НАЦИОНАЛЬНЫЙ ИССЛЕДОВАТЕЛЬСКИЙ УНИВЕРСИТЕТ ИТМО»
      ]
      #v(1fr)
      #text(size: 17pt, weight: "bold")[#title]
      #if subtitle != "" [ #v(0.3cm) #text(size: 13pt)[#subtitle] ]
      #v(1fr)
      #align(right)[
        #block(width: 45%, align(left)[
          #if work-number != "" [Работа №#work-number \ ]
          Выполнил: #author #if group != "" [(гр. #group)] \
          #if reviewer != "" [Проверил: #reviewer]
        ])
      ]
      #v(1fr)
      #city \
      #datetime.today().display("[year]")
    ]
  }
  pagebreak()

  // Table of contents
  set page(numbering: "1")
  counter(page).update(1)
  outline(title: "Содержание", indent: auto, depth: 2)
  pagebreak()

  // Body typography: justified, indented first line (research-paper look)
  set par(justify: true, leading: 0.72em, first-line-indent: (amount: 1.2em, all: false))
  body
}

// Callout for a problem statement / task formulation
#let task-box(title: "Постановка задачи", body) = {
  block(
    fill: luma(246),
    stroke: (left: 3pt + rgb("#1f4e79")),
    inset: 1em,
    width: 100%,
    radius: 3pt,
    above: 1em,
    below: 1.1em,
  )[
    #text(weight: "bold", fill: rgb("#1f4e79"))[#title]
    #v(0.4em)
    #body
  ]
}

// Callout for a key empirical finding
#let finding(body) = {
  block(
    fill: rgb("#f0f6ec"),
    stroke: (left: 3pt + rgb("#5a7d2a")),
    inset: 1em,
    width: 100%,
    radius: 3pt,
    above: 1em,
    below: 1.1em,
  )[
    #text(weight: "bold", fill: rgb("#5a7d2a"))[Вывод]
    #v(0.4em)
    #body
  ]
}
