% Nathan's exam class
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{nmd/exam}[2014/08/31 - Semester start edition]
\RequirePackage{nmd/common}
\RequirePackage{xkeyval}
\DeclareOptionX{stretch}{\def\nmdhw@baselinestretch{#1}}
\DeclareOptionX{margin}{\def\nmdhw@margin{#1}}
\PassDownOptionToPackage{times}{nmd/fonts}
\PassDownOptionToPackage{utopia}{nmd/fonts}
\PassDownOptionToPackage{lucida}{nmd/fonts}
\PassDownOptionToPackage{tikz}{nmd/graphics}
\PassDownOptionToPackage{xy}{nmd/graphics}
\newboolean{nmd@draft}
\DeclareOption{draftmode}{\nmd@drafttrue}
\ExecuteOptionsX{stretch=1.1, margin=0.8in}
\ProcessOptions

\LoadClass[12pt]{article}
\RequirePackage[letterpaper, margin=\nmdhw@margin]{geometry}

\RequirePackage{amsmath,amssymb}
\renewcommand{\baselinestretch}{\nmdhw@baselinestretch}
\setlength{\textwidth}{7.5in}
\setlength{\evensidemargin}{ -0.6in}
\setlength{\oddsidemargin}{ -0.4in}
\setlength{\textheight}{10.45in}
\setlength{\topmargin}{-1.25in}
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


%%% Load the rest of the nmd-specific styles
\RequirePackage{nmd/fonts}
\RequirePackage{nmd/graphics}
\RequirePackage{nmd/math}
\graphicspath{{images/}}
\RequirePackage[colorlinks=true, linkcolor=blue, citecolor=blue, urlcolor=blue]{hyperref}