#let datetime-display(date) = {
  if date == none {
    [#h(3em)年#h(1.5em)月#h(1.5em)日]
  } else {
    date.display("[year padding:none]年[month padding:none]月[day padding:none]日")
  }
}

#let datetime-display-without-day(date) = {
  if date == none {
    [#h(3em)年#h(1.5em)月]
  } else {
    date.display("[year padding:none]年[month padding:none]月")
  }
}

#let datetime-en-display(date) = (
  if date == none {
    [#h(10em),#h(2em)]
  } else {
    if date.day() == 1 or date.day() == 21 or date.day() == 31 {
      date.display("[month repr:long]") + " " + $date.display("[day padding:none]")^"st"$ + ", " + date.display("[year padding:none]")
    } else if date.day() == 2 or date.day() == 22 {
      date.display("[month repr:long]") + " " + $date.display("[day padding:none]")^"nd"$ + ", " + date.display("[year padding:none]")
    } else if date.day() == 3 or date.day() == 23 {
      date.display("[month repr:long]") + " " + $date.display("[day padding:none]")^"rd"$ + ", " + date.display("[year padding:none]")
    } else {
      date.display("[month repr:long]") + " " + $date.display("[day padding:none]")^"th"$ + ", " + date.display("[year padding:none]")
    }
  }
)

#let datetime-en-display-without-day(date) = {
  if date == none {
    [#h(10em),#h(2em)]
  } else {
    date.display("[month repr:long], [year padding:none]")
  }
}
