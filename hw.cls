% Nathan's worksheet LaTeX class

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{nmd/hw}[2014/08/31 - Semester start edition]
\RequirePackage{nmd/common}
\RequirePackage{expl3}
\RequirePackage{xkeyval}
\RequirePackage{xstring}
\RequirePackage{datetime}
\DeclareOptionX{stretch}{\def\nmdhw@baselinestretch{#1}}
\DeclareOptionX{margin}{\def\nmdhw@margin{#1}}
\newboolean{nmdhw@draft}
\DeclareOption{draft}{\nmdhw@drafttrue}
\PassDownOptionToPackage{times}{nmd/fonts}
\PassDownOptionToPackage{utopia}{nmd/fonts}
\PassDownOptionToPackage{lucida}{nmd/fonts}
\PassDownOptionToPackage{tikz}{nmd/graphics}
\PassDownOptionToPackage{xy}{nmd/graphics}
\ExecuteOptionsX{stretch=1.1, margin=0.8in}
\ProcessOptionsX
\ProcessOptions

\LoadClass[12pt]{article}
\RequirePackage[letterpaper, margin=\nmdhw@margin]{geometry}

\RequirePackage{amsmath,amssymb}
\renewcommand{\baselinestretch}{\nmdhw@baselinestretch}
\setlength{\parindent}{0pt}
\pagestyle{empty}


%%% For fun, let's extract the hw date from the file name,
%%% which should have the form "hw(num)-(year)-(month)-(day).tex"
%%% where the prefix 'hw' can be replaced with 'mt' or 'fi'.  

\newcommand{\nmdhw@stripleadingzero}[1]{\IfBeginWith{#1}{0}{\StrGobbleLeft{#1}{1}[#1]}{\relax}}
\IfBeginWith*{\jobname}{hw}{%
  \StrBehind*{\jobname}{hw}[\nmdhw@jobname]
}{}
\IfBeginWith*{\jobname}{mt}{%
  \StrBehind*{\jobname}{mt}[\nmdhw@jobname]
}{}
\IfBeginWith*{\jobname}{fi}{%
  \StrBehind*{\jobname}{fi}[\nmdhw@jobname]
}{}
\StrCut{\nmdhw@jobname}{-}{\nmdhw@number}{\nmdhw@jobname}
\StrCut{\nmdhw@jobname}{-}{\nmdhw@year}{\nmdhw@jobname}
\StrCut{\nmdhw@jobname}{-}{\nmdhw@month}{\nmdhw@day}
\nmdhw@stripleadingzero{\nmdhw@number}
\nmdhw@stripleadingzero{\nmdhw@day}
\def\nmdhw@dayofweek{\dayofweekname{\nmdhw@day}{\nmdhw@month}{\nmdhw@year}}
\newcommand{\class}[2][HW]{% 
  \textsf{\textbf{\large Math #2: %
      \ifnmdhw@draft \color{red} //DRAFT ONLY// \else \relax\fi %
      #1 \nmdhw@number\ due % 
  \nmdhw@dayofweek, \monthname[\nmdhw@month] \nmdhw@day, \nmdhw@year.}}
  \vspace{0.5cm}
  
}

%%% Main problem list; subproblems handled by enumerate

\newcounter{problems}
\newenvironment{problems}{
  \begin{list}%
    % label
    {\arabic{problems}.}
    % parameters
    {
      \setlength{\leftmargin}{0.7cm}
      \setlength{\labelwidth}{0.5cm}
      \setlength{\labelsep}{0.3cm}
      \usecounter{problems}
    }
  }{\end{list}}

\renewcommand{\labelenumi}{(\alph{enumi}) }
\renewcommand{\theenumi}{\alph{enumi}}

%%% Load the rest of the nmd-specific styles
\RequirePackage{nmd/fonts}
\RequirePackage{nmd/graphics}
\RequirePackage{nmd/math}
\graphicspath{{images/}}
\RequirePackage[colorlinks=true, linkcolor=blue, citecolor=blue, urlcolor=blue]{hyperref}