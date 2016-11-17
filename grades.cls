\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{nmd/grades}[2014/12/16 - Semester end edition]
\RequirePackage{nmd/common}
\ProcessOptions
\LoadClassWithOptions{article} 
\RequirePackage[tikz]{nmd/graphics}
\RequirePackage[margin=0.5in]{geometry}
\RequirePackage[utopia]{nmd/fonts}
\setlength{\parindent}{0cm}
\addtolength{\parskip}{4pt}



% Drawing grade plots
\definecolor{nmd@Agrade}{gray}{0.9}
\definecolor{nmd@Bgrade}{gray}{1.0}
\definecolor{nmd@Cgrade}{gray}{0.9}
\definecolor{nmd@Dgrade}{gray}{1.0}
\definecolor{nmd@Fgrade}{gray}{0.9}
\pgfkeys{/tikz/plot height/.initial=3}
\pgfkeys{/tikz/grade label below/.initial=0.2}

% Grade boxes.  Args are:  xmin, xmax, grade, proportion
\newcommand{\gradebox}[4]{%
  \def\nmd@plotheight{\pgfkeysvalueof{/tikz/plot height}}
  \coordinate (A) at (#1, 0);
  \coordinate (B) at (#2, 0);
  \coordinate (C) at (#2, \nmd@plotheight + 1.0);
  \coordinate (D) at (#1, \nmd@plotheight + 1.0);

  \fill[color=nmd@#3grade] (A) rectangle (C);
  \draw[color=nmd@#3grade] (D) -- (C) node 
     [midway, below=\pgfkeysvalueof{/tikz/grade label below}, color=black] {\large \emph{#3}}; 
  \node[below left=0.07] at (C) {#4\%};
}

% ticks: xmin, xmax, ticks. 
\newcommand{\axisandticks}[3]{%
 \begin{scope}[color=black, ultra thick]
   \draw (#1, 0) -- (#2,0);
   \foreach \x in {#3}
    {
      \draw (\x, -0.5) node {$\x$};
      \draw (\x, -0.2) -- (\x, 0);
    }
  \end{scope}
}

% vertical bars each representing one student
\newcommand{\drawbars}[1]{%
  \foreach \x in {#1}
  {
    \draw[color=darkgray, fill=darkgray, line width=1pt] 
        (\x, 0) -- (\x, \pgfkeysvalueof{/tikz/plot height});
  };
}

% histogram bar
\pgfkeys{/tikz/histogram bar width/.initial=1}
\newcommand{\onehistbar}[2]{
  \def\nmd@histbarw{\pgfkeysvalueof{/tikz/histogram bar width}}
  \coordinate (A) at (#1 - 0.5*\nmd@histbarw, 0);
  \coordinate (C) at (#1 + 0.5*\nmd@histbarw, #2*\pgfkeysvalueof{/tikz/plot height});
  \filldraw[color=black!35] (A) rectangle (C);
}

% histogram
\newcommand{\histogrambars}[1]{
  \foreach \x / \y in {#1} {
    \onehistbar{\x}{\y};
  }
}

% student bar
\newcommand{\studentbar}[1]{%
\draw[color=black, line width=4pt] (#1, 0) -- (#1, 1.15*\nmd@plotheight);
}

