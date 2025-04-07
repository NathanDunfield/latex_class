% Nathan's exam class
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{nmd/nmd-exam}[2016/08/31 - Semester start edition]
\RequirePackage{nmd/nmd-common}
\RequirePackage{xkeyval}
\DeclareOptionX{stretch}{\def\nmdexam@baselinestretch{#1}}
\DeclareOptionX{inner}{\def\nmdexam@inner{#1}}
\DeclareOptionX{outer}{\def\nmdexam@outer{#1}}
\DeclareOptionX{top}{\def\nmdexam@top{#1}}
\DeclareOptionX{bottom}{\def\nmdexam@bottom{#1}}
\PassDownOptionToPackage{times}{nmd-fonts}
\PassDownOptionToPackage{stix}{nmd-fonts}
\PassDownOptionToPackage{utopia}{nmd-fonts}
\PassDownOptionToPackage{lucida}{nmd-fonts}
\PassDownOptionToPackage{tikz}{nmd-graphics}
\PassDownOptionToPackage{xy}{nmd-graphics}
\newboolean{nmd@draft}
\DeclareOption{draftmode}{\nmd@drafttrue}
\newboolean{nmd@elevenpt}
\newboolean{nmd@eleventwofivept}
\newboolean{nmd@elevenfivept}
\newboolean{nmd@elevensevenfivept}
\newboolean{nmd@twelvept}
\DeclareOption{11pt}{\nmd@elevenpttrue \PassOptionsToClass{11pt}{article}}
\DeclareOption{11.25pt}{\nmd@eleventwofivepttrue \PassOptionsToClass{11pt}{article}}
\DeclareOption{11.5pt}{\nmd@elevenfivepttrue \PassOptionsToClass{11pt}{article}}
\DeclareOption{11.75pt}{\nmd@elevensevenfivepttrue \PassOptionsToClass{12pt}{article}}
\DeclareOption{12pt}{\nmd@twelvepttrue\PassOptionsToClass{12pt}{article}}%%% make 12 point the default
\ifnotthen{\boolean{nmd@elevenpt}\or\boolean{nmd@elevenfivept}\or\boolean{nmd@eleventwofivept}\or\boolean{nmd@elevensevenfivept}\or\boolean{nmd@twelvept}}{%
   \nmd@twelvepttrue
   \PassOptionsToClass{12pt}{article}
}
\ProcessOptions
\ExecuteOptionsX{stretch=1.1, inner=1.5cm, outer=1cm, top=1cm, bottom=1cm}
\ProcessOptionsX

%%% make 12 point the default
\ifnotthen{\boolean{nmd@elevenpt}\or\boolean{nmd@elevenfivept}\or\boolean{nmd@eleventwofivept}\or\boolean{nmd@elevensevenfivept}\or\boolean{nmd@twelvept}}{%
   \nmd@twelvepttrue
   \PassOptionsToClass{12pt}{article}
}

\LoadClass{article}

%%% Nonstandard sizes are useful when trying to hit a precise page
%%% limit.
\ifnmd@eleventwofivept
  \usepackage[fontsize=11.25pt]{scrextend}
\fi
\ifnmd@elevenfivept
  \usepackage[fontsize=11.5pt]{scrextend}
  \fi
\ifnmd@elevensevenfivept
  \usepackage[fontsize=11.75pt]{scrextend}
\fi

\RequirePackage[letterpaper, inner=\nmdexam@inner, outer=\nmdexam@outer, 
                            top=\nmdexam@top, bottom=\nmdexam@bottom]{geometry}

\renewcommand{\baselinestretch}{\nmdexam@baselinestretch}
\setlength{\parindent}{0pt}
\pagestyle{empty}

% Two column problem format 
% Args are (width 1, width 2, text 1, text 2)

\newcommand{\twocolprob}[4]{
 \begin{minipage}[t]{#1}
    #3
  \end{minipage}
  \hspace{0.5in}
  \begin{minipage}[t]{#2}
    #4
  \end{minipage}
}


% Problem and subproblem lists

\newcounter{probs}
\newenvironment{problems}{
  \begin{list}{\textbf{\arabic{probs}.}}
    {\usecounter{probs}
      \setlength{\leftmargin}{1.5em}
      \setlength{\itemsep}{3ex}
    }
 }
{\end{list}}

\newcounter{subprobs}
\newenvironment{subproblems}{
  \begin{list}{(\alph{subprobs})}
    {\usecounter{subprobs}
      \setlength{\leftmargin}{1.5em}
      \setlength{\itemsep}{2ex}
    }
 }
{\end{list}}

%
% Test formating macros
%

\ifnmd@draft
   \newcommand{\pagebk}{\relax}
\else
  \newcommand{\pagebk}{% 
    \vfill
    \pagebreak}
\fi


\newcommand{\nmd@formatpoints}[1]{%
  \ifthenelse{\equal{#1}{1}}{1 point}{#1 points}}

\newcommand{\vs}[1]{\vspace{#1}}
\newcommand{\pts}[1]{ { \bf(\nmd@formatpoints{#1})} }
\newcommand{\ptseach}[1]{{\bf(\nmd@formatpoints{#1} each)} }

% Answer boxes
\setlength{\fboxsep}{7pt}
\newcommand{\ansbox}[1]{\fbox{$\displaystyle \vphantom{\big(} #1$}}
\newcommand{\ansblank}{\hspace{0.5in}}
\newcommand{\twotuple}{\hspace{1in}, \hspace{1in}}
\newcommand{\threetuple}{\hspace{.4in}, \hspace{.4in}, \hspace{.4in}}
\newcommand{\bigthreetuple}{\hspace{1.3in}, \hspace{1.3in}, \hspace{1.3in}}
\newcommand{\Bigthreetuple}{\hspace{1.6in}, \hspace{1.6in}, \hspace{1.6in}}
\newcommand{\ansvec}{\Big\langle\threetuple\Big\rangle}
\newcommand{\anstwovec}[1]{\Big\langle \hspace{#1}, \hspace{#1} \Big\rangle}
\newcommand{\ansthreevec}[1]{\Big\langle \hspace{#1}, \hspace{#1}, \hspace{#1} \Big\rangle}
\newcommand{\ansbigvec}{\Big\langle\bigthreetuple\Big\rangle}
\newcommand{\ansBigvec}{\Big\langle\Bigthreetuple\Big\rangle}
\newcommand{\anspt}{\Big(\threetuple\Big)}
\newcommand{\anssep}{\hspace{1em}}
\newcommand{\coeffbox}{\fbox{\rule[-.3cm]{0cm}{.7cm}\hspace{2em}}\;}
\newcommand{\ansplane}{Equation: \quad\coeffbox $x +$ \coeffbox $y +$
\coeffbox $z = $ \coeffbox}
\newcommand{\checkbox}{\fbox{$\vphantom{)}$\hspace{1.0em}}}
\newcommand{\abox}{\mbox{\colorbox{white}{\checkbox}}}
\newcommand{\posnegzero}{\fbox{negative \quad  zero \quad positive}}
\newcommand{\truefalse}{\fbox{true \quad  false}}

%%% Load the rest of the nmd-specific styles
\RequirePackage{nmd/nmd-fonts}
\RequirePackage{nmd/nmd-graphics}
\RequirePackage{nmd/nmd-math}
\graphicspath{{images/}}
\RequirePackage[colorlinks=true, linkcolor=blue, citecolor=blue, urlcolor=blue]{hyperref}