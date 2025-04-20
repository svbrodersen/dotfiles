local function math()
  return vim.fn["vimtex#syntax#in_mathzone"]() == 1
end
local function comment()
  return vim.fn["vimtex#syntax#in_comment"]() == 1
end

--- Return true if inside the given vimtex environment (e.g. "tikzpicture")
local function env(name)
  local inside = vim.fn["vimtex#env#is_inside"](name)
  -- vimtex#env#is_inside() returns a tuple {start_line, end_line}
  return inside[1] > 0 and inside[2] > 0
end

local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local sn = ls.snippet_node
local rep = require("luasnip.extras").rep
local fmt = require("luasnip.extras.fmt").fmt

return {
  -- iff in math mode
  s({ trig = "iff", dscr = "iff", wordTrig = false }, t("\\iff"), { condition = math() }),

  -- inline math with auto space
  s(
    { trig = "mk", dscr = "inline math", wordTrig = false },
    fmt("${}{}${}", {
      i(1),
      f(function(_, snip)
        local prev = snip.env.TM_TEXT_BEFORE:sub(-1)
        return (prev and not prev:match("[%s%p]")) and " " or ""
      end, {}),
      i(0),
    }),
    {
      condition = function()
        return not comment()
      end,
    }
  ),

  -- fraction
  s(
    { trig = "//", dscr = "fraction", regTrig = false, wordTrig = false },
    t("\\frac{"),
    i(1),
    t("}{"),
    i(2),
    t("}"),
    i(0),
    { condition = math() }
  ),

  -- auto_subscripts
  s(
    { trig = "([A-Za-z])_(%d%d)", regTrig = true, wordTrig = false },
    fmt("{}_{{{}}}", {
      f(function(_, snip)
        return snip.captures[1]
      end, {}),
      f(function(_, snip)
        return snip.captures[2]
      end, {}),
    }),
    { condition = math() }
  ),
  s(
    { trig = "([A-Za-z])(%d)", regTrig = true, wordTrig = false },
    fmt("{}_{}", {
      f(function(_, snip)
        return snip.captures[1]
      end, {}),
      f(function(_, snip)
        return snip.captures[2]
      end, {}),
    }),
    { condition = math() }
  ),

  -- math snippets
  s(
    { trig = "ceil", dscr = "ceil", wordTrig = false },
    fmt("\\left\\lceil {} \\right\\rceil", { i(1) }),
    { condition = math() }
  ),
  s(
    { trig = "floor", dscr = "floor", wordTrig = false },
    fmt("\\left\\lfloor {} \\right\\rfloor", { i(1) }),
    { condition = math() }
  ),
  s({ trig = "pmat", dscr = "pmatrix", wordTrig = false }, fmt("\\begin{pmatrix} {} \\end{pmatrix}", { i(1) })),
  s({ trig = "bmat", dscr = "bmatrix", wordTrig = false }, fmt("\\begin{bmatrix} {} \\end{bmatrix}", { i(1) })),
  s({ trig = "%(", dscr = "left(", wordTrig = false }, fmt("\\left( {} \\right)", { i(1) }), { condition = math() }),
  s(
    { trig = "lr|", dscr = "left|right|", wordTrig = false },
    fmt("\\left| {} \\right|", { i(1) }),
    { condition = math() }
  ),
  s(
    { trig = "lr%[", dscr = "left[ right]", wordTrig = false },
    fmt("\\left[ {} \\right]", { i(1) }),
    { condition = math() }
  ),
  s(
    { trig = "lra", dscr = "left< right>", wordTrig = false },
    fmt("\\left<{} \\right>", { i(1) }),
    { condition = math() }
  ),

  -- sums, products, limits, etc.
  s(
    { trig = "sum", dscr = "sum", wordTrig = false },
    fmt("\\sum_{{n={}}}^{{{}}} {}", { i(1, "1"), i(2, "\\infty"), i(3, "a_n z^n") })
  ),
  s(
    { trig = "prod", dscr = "product", wordTrig = false },
    fmt("\\prod_{{n={}}}^{{{}}} {}", { i(1, "1"), i(2, "\\infty"), i(3, "") })
  ),
  s({ trig = "lim", dscr = "limit", wordTrig = false }, fmt("\\lim_{{{} \\to {}}}", { i(1, "n"), i(2, "\\infty") })),
  s(
    { trig = "dint", dscr = "integral", wordTrig = false },
    fmt("\\int_{{{}}}^{{{}}} {}", { i(1, "-\\infty"), i(2, "\\infty"), i(3) }),
    { condition = math() }
  ),
  s(
    { trig = "ceil", dscr = "ceil", wordTrig = false },
    fmt("\\left\\lceil {} \\right\\rceil", { i(1) }),
    { condition = math() }
  ),

  -- TikZ
  s(
    { trig = "tikzpic", dscr = "begin tikzpicture…end tikzpicture", wordTrig = false },
    fmt(
      [[  \\begin{{tikzpicture}}
    {}
\\end{{tikzpicture}} ]],
      { i(1) }
    )
  ),

  -- Plot environment (figure + tikzpicture + axis)
  s(
    { trig = "plot", dscr = "TikZ plot environment", wordTrig = false },
    fmt(
      [[
\begin{{figure}}[{}]
  \centering
  \begin{{tikzpicture}}
    \begin{{axis}}[
      xmin= {}, xmax= {},
      ymin= {}, ymax= {},
      axis lines = middle,
    ]
      \addplot[domain={}:{}, samples={} ]{{}};
    \end{{axis}}
  \end{{tikzpicture}}
  \caption{{{}}}
  \label{{{}}}
\end{{figure}}
]],
      {
        i(1, "htpb"), -- figure placement
        i(2, -10), -- xmin
        i(3, 10), -- xmax
        i(4, -10), -- ymin
        i(5, 10), -- ymax
        i(6, 0), -- domain start
        rep(6), -- domain end mirrors start? adjust if needed
        i(7, 100), -- samples
        i(8, "f(x)"), -- function
        i(9, "label"), -- caption & label
      }
    )
  ),

  -- TikZ node
  s(
    { trig = "nn", dscr = "TikZ node", wordTrig = false },
    fmt([[\node[{}] ({}) {}{{${}$}};]], {
      i(1, "options"), -- node options
      i(2, "name"), -- node name
      c(3, {
        t("at ("),
        i(1, "0,0"),
        t(")"),
        t(""),
      }), -- position
      rep(2), -- node text mirrors name
    }),
    {
      condition = function()
        return not comment()
      end,
    }
  ),
}
