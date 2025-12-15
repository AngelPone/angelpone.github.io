#set page(margin: (x: 5em))
#import "@preview/fontawesome:0.6.0": fa-icon

#let fai(name) = {
  set text(size: 0.66em)
  fa-icon(name)
}

#let section-title(name) = {
  rect(inset: 5pt, stroke: none, text(size: 13pt, name, weight: "bold"))
}

#let data = json("../.quarto/cv/data.json")

#grid(columns: (1fr, 5fr), row-gutter: 10pt,
[= CV],[], 

// Publications
section-title("Publications"),
[
  #show "Bohan Zhang": it => text(weight: "bold", it)
  #enum(..data.publications, numbering: "[1]")
],
grid.hline(),

// Education
[#section-title("Education")],[
#table(
  inset: (x, y) => {
    if (y == 6) { (top: 5pt, bottom: -4pt)} else {
      (top: 5pt, bottom: 5pt)
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
  columns: (4em, auto, auto), stroke: none,
  align: (center, left, left),
  ..data.conferences.map(x => {
    let inset = (x: 0pt, top: 5pt, bottom: 5pt)
    if x.year == "2021" {
      inset.bottom = -5pt
    }
    (table.cell(x.year, inset: inset), 
    table.cell(x.conference + " (" + x.place + ") ", inset: inset), 
    table.cell(text(gray, x.date), inset: inset))
    
  }).flatten()  
  )
 }, grid.hline(),
section-title("Software")

)