// 字号定义
#let font-sizes = (
  initial-size: 42pt,
  small-initial-size: 36pt,
  size-1: 26pt,
  small-size-1: 24pt,
  size-2: 22pt,
  small-size-2: 18pt,
  size-3: 16pt,
  small-size-3: 15pt,
  size-4: 14pt,
  medium-size-4: 13pt,
  small-size-4: 12pt,
  size-5: 10.5pt,
  small-size-5: 9pt,
  size-6: 7.5pt,
  small-size-6: 6.5pt,
  size-7: 5.5pt,
  small-size-7: 5pt,
)

// 字体族定义
#let font-families = (
  // 宋体，属于「有衬线字体」，一般可以等同于英文中的 Serif Font
  // 这一行分别是「新罗马体（有衬线英文字体）」、「宋体（MacOS）」、「宋体（Windows）」、「华文宋体」
  song: ("Times New Roman", "Songti SC", "SimSun", "STSong"),

  // 黑体，属于「无衬线字体」，一般可以等同于英文中的 Sans Serif Font
  // 这一行分别是「新罗马体（有衬线英文字体）」、「黑体（MacOS）」、「黑体（Windows）」、「华文黑体」
  hei: ("Times New Roman", "Heiti SC", "SimHei", "STHeiti"),

  // 楷体
  // 这一行分别是「新罗马体（有衬线英文字体）」、「楷体（MacOS）」、「锴体（Windows）」、「华文楷体」、「方正楷体」
  kai: ("Times New Roman", "Kaiti SC", "KaiTi", "STKaiti", "KaiTi_GB2312"),

  // 仿宋
  // 这一行分别是「新罗马体（有衬线英文字体）」、「方正仿宋」、「仿宋（MacOS）」、「仿宋（Windows）」、「华文仿宋」
  fangsong: ("Times New Roman", "FangSong_GB2312", "FangSong SC", "FangSong", "STFangSong"),

  // 等宽字体，用于代码块环境，一般可以等同于英文中的 Monospaced Font
  // 这一行分别是「Menlo(MacOS 等宽英文字体)」、「Courier New(等宽英文字体)」、「黑体（MacOS）」、「黑体（Windows）」、「华文黑体」
  monospace: ("Menlo", "Courier New", "Heiti SC", "SimHei", "STHeiti"),
)
