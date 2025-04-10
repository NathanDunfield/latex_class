% Nathan's worksheet LaTeX class

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{nmd/nmd-hw}[2014/08/31 - Semester start edition]
\RequirePackage{nmd/nmd-common}
\RequirePackage{expl3}
\RequirePackage{xkeyval}
\RequirePackage{xstring}
\RequirePackage{datetime}
\DeclareOptionX{stretch}{\def\nmdhw@baselinestretch{#1}}
\DeclareOptionX{margin}{\def\nmdhw@margin{#1}}
\PassDownOptionToPackage{a4paper}{geometry}
\PassDownOptionToPackage{letterpaper}{geometry}
\newboolean{nmdhw@draft}
\newboolean{nogeometry}
\newboolean{elevenpt}
\newboolean{eleventwofivept}
\newboolean{elevenfivept}
\newboolean{elevensevenfivept}
\newboolean{twelvept}
\DeclareOption{draft}{\nmdhw@drafttrue}
\PassDownOptionToPackage{times}{nmd-fonts}
\PassDownOptionToPackage{stix}{nmd-fonts}
\PassDownOptionToPackage{utopia}{nmd-fonts}
\PassDownOptionToPackage{lucida}{nmd-fonts}
\PassDownOptionToPackage{tikz}{nmd-graphics}
\PassDownOptionToPackage{xy}{nmd-graphics}
\DeclareOption{11pt}{\elevenpttrue \PassOptionsToClass{11pt}{article}}
\DeclareOption{11.25pt}{\eleventwofivepttrue \PassOptionsToClass{11pt}{article}}
\DeclareOption{11.5pt}{\elevenfivepttrue \PassOptionsToClass{11pt}{article}}
\DeclareOption{11.75pt}{\elevensevenfivepttrue \PassOptionsToClass{12pt}{article}}
\DeclareOption{12pt}{\twelvepttrue \PassOptionsToClass{12pt}{article}}
\DeclareOption{nogeometry}{\nogeometrytrue}
\ExecuteOptionsX{stretch=1.1, margin=0.8in}
\ProcessOptionsX
\ProcessOptions

%%% make 12 point the default
\ifnotthen{\boolean{elevenpt}\or\boolean{elevenfivept}\or\boolean{eleventwofivept}\or\boolean{elevensevenfivept}}{%
   \twelvepttrue
   \PassOptionsToClass{12pt}{article}
}

\LoadClass{article}
\RequirePackage[margin=\nmdhw@margin]{geometry}
\RequirePackage{enumitem}
\renewcommand{\baselinestretch}{\nmdhw@baselinestretch}
\setlength{\parindent}{0pt}
\pagestyle{empty}

%%% Nonstandard sizes are useful when trying to hit a precise page
%%% limit.
\ifeleventwofivept
  \usepackage[fontsize=11.25pt]{scrextend}
\fi
\ifelevenfivept
  \usepackage[fontsize=11.5pt]{scrextend}
  \fi
\ifelevensevenfivept
  \usepackage[fontsize=11.75pt]{scrextend}
\fi


%%% For fun, let's extract the hw date from the file name,
%%% which should have the form "hw(num)-(year)-(month)-(day).tex"
%%% where the prefix 'hw' can be replaced with 'mt', 'fi', or 'ws'.  

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
\IfBeginWith*{\jobname}{ws}{%
  \StrBehind*{\jobname}{ws}[\nmdhw@jobname]
}{}
\StrCut{\nmdhw@jobname}{-}{\nmdhw@number}{\nmdhw@jobname}
\StrCut{\nmdhw@jobname}{-}{\nmdhw@year}{\nmdhw@jobname}
\StrCut{\nmdhw@jobname}{-}{\nmdhw@month}{\nmdhw@jobname}
\StrCut{\nmdhw@jobname}{-}{\nmdhw@day}{\nmdhw@jobname}
\nmdhw@stripleadingzero{\nmdhw@number}
\nmdhw@stripleadingzero{\nmdhw@day}
\def\nmdhw@dayofweek{\dayofweekname{\nmdhw@day}{\nmdhw@month}{\nmdhw@year}}



\newcommand{\classtemplate}[3]{% 
  \textsf{\textbf{\large #2: %
      \ifnmdhw@draft \color{red} //DRAFT ONLY// \else \relax\fi %
      #1 \nmdhw@number\ #3 % 
  \nmdhw@dayofweek, \monthname[\nmdhw@month] \nmdhw@day, \nmdhw@year.}}
  \vspace{0.5cm}
  
}

\newcommand{\class}[2][HW]{\classtemplate{#1}{Math #2}{due}}
\newcommand{\worksheet}[1]{\classtemplate{Worksheet}{Math #1}{}}

%%% Main problem list; subproblems handled by enumerate

\newlist{problems}{enumerate}{10}
\setlist[problems]{label=\arabic*.,
  leftmargin=0.7cm,
  labelwidth=0.5cm,
  labelsep=0.3cm,
}

\renewcommand{\labelenumi}{(\alph{enumi}) }
\renewcommand{\theenumi}{\alph{enumi}}

%%% Load the rest of the nmd-specific styles
\RequirePackage{nmd/nmd-fonts}
\RequirePackage{nmd/nmd-graphics}
\RequirePackage{nmd/nmd-math}
\graphicspath{{images/}}
\RequirePackage[colorlinks=true, linkcolor=blue, citecolor=blue, urlcolor=blue]{hyperref}