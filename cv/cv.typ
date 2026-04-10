#set page(margin: (x: 5em))
#import "@preview/fontawesome:0.6.0": fa-icon

#let fai(name) = fa-icon(name, top-edge: "baseline")

  
#set enum(numbering: "[1]")

#let section-title(name) = {
  rect(inset: 0em, stroke: none, text(size: 1.2em, name, weight: "bold"))
}

#let data = json("../.quarto/cv/data.json")

#text(size: 2em)[*Bohan Zhang*]

#grid(columns: (1fr, 5fr), inset: ((top: 1em, bottom: 1em), (top: 1em, bottom: 1em, left: 0em, right: 0em)),
grid.hline(),
// Publications
section-title("Publications"),
[
  #show "Bohan Zhang": it => text(weight: "bold", it)
  #enum(..data.publications)
],
grid.hline(),
// Education
[#section-title("Education")],[
#table(
  inset: (x, y) => {
    if (y == 3) { (top: 0em, bottom: 1em) } 
    else if (y == 4) {
      (top: 1em, bottom: 0.8em)
    } else if (y==6) {
      (top: 0em, bottom: 0em)
    } else {
      (top: 0pt, bottom: 0.8em)
    }
  },
  align: (center+horizon, left, left),
  stroke: none, columns: (4em, 1fr),
  // PhD
  [2025.06], [*PhD* in *Statistics*],
  table.cell(text(size: 1.3em, $arrow.t$), rowspan: 2), [~~School of Economics and Management, Beihang University],
  [~~#fai("chevron-right")~ Supervisors:~ Prof. Haitao Zheng, Prof. Yanfei Kang],
  [2020.09], [~~#fai("chevron-right")~ Thesis:~ #text(style: "italic", [Hierarchical forecasting approaches in complex scenarios])],
  table.hline(position: top),
  // Bachelor
  [2020.06], [*Bachelor* in *Economic Statistics*],
  $arrow.t$, [~~School of Economics and Management, Beihang University],
  [2016.09],[~~#fai("chevron-right")~ Supervisor: Prof. Yanfei Kang])
], grid.hline(),

// Talks
section-title("Talks"),
{
  show regex("\d+st"): it => {
    $it.text.replace("st", "")^("st")$
  }
  show regex("\d+rd"): it => {
    $it.text.replace("rd", "")^("rd")$
  }
  show regex("\d+th"): it => {
    $it.text.replace("th", "")^("th")$
  }
  table(
  columns: (3em, 1fr, 4em), stroke: none,
  align: (left, left, left),
  ..data.conferences.map(x => {
    let inset = (x: 0pt, top: 0em, bottom: 0.7em)
    let inset2 = (x: 0pt, top: 0em, bottom: 1em)
    if x.year == "2021" {
      inset2.bottom = 0em
    }
    (table.cell(x.year, inset: inset), 
    table.cell([*#x.conference*], inset: inset), 
    table.cell(text(gray, x.date), inset: inset),
    table.cell([], inset: inset2),
    table.cell(x.place, inset: inset2), 
    table.cell([], inset: inset2))
  }).flatten()  
  )
 }, grid.hline(),

// Software
section-title("Software"),
{
show "Python Package": it => {fai("python")}
show "R Package": it => {fai("r-project")}
enum(..data.software.map(x => {
  [*#x.title*: #x.full #h(1fr) #x.type #link(x.link)[#fai("github")] \ #x.description]
}))
},
grid.hline(),

section-title("Experiences"),
[],
section-title("Employment"),
[]
)