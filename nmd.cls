%%% Nathan M. Dunfield's personal LaTeX class %%%
%
%  Main options: gt, ams, custom
%  Font options: times, utopia, lucida
%  
%  Formating commands:
%    \trim, \laptop, \printing

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{nmd}[2011/07/25 - Post Australia Funk Edition]

%%% Setup options

\newif\ifgt
\newif\ifams
\newif\ifcustom
\newif\iftimes
\newif\ifutopia
\newif\iflucida
\newif\ifninept
\newif\iftenpt
\newif\ifelevenpt
\newif\iftwelvept
\DeclareOption{gt}{\gttrue}
\DeclareOption{ams}{\amstrue}
\DeclareOption{custom}{\customtrue}
\DeclareOption{times}{\timestrue}
\DeclareOption{utopia}{\utopiatrue}
\DeclareOption{lucida}{\lucidatrue}

% The GT style has a fixed font, but the AMS one doesn't.  
\DeclareOption{9pt}{\ninepttrue}
\DeclareOption{10pt}{\tenpttrue}
\DeclareOption{11pt}{\elevenpttrue}
\DeclareOption{12pt}{\twelvepttrue}

\ProcessOptions

%%% Switch to turn on Nathan's features if his custom option file exists
\newif\ifnmd
\InputIfFileExists{user-is-nathan-dunfield}{\nmdtrue}{\nmdfalse}

%%% Other people probably don't have the Lucida fonts
\ifnmd \relax \else \iflucida \lucidafalse \utopiatrue \fi \fi

%%%  Make the GT based style the default
\gttrue
\ifams \gtfalse \fi
\ifcustom \gtfalse \fi

%%% Load basic style file %%% 

\ifgt
 \LoadClass{gtpart} 
  %% Improve fit on US letter
  \addtolength{\topmargin}{-1.3cm}
  \addtolength{\oddsidemargin}{0.35cm}
  % The style actually has no footers
  \setlength{\footskip}{0pt}

  \usepackage{tocloft}
  \setlength{\cftbeforesecskip}{0.05cm}
  \renewcommand{\cftsecleader}{\cftdotfill{\cftdotsep}} 

  % \dedicatory{{\scriptsize \versioninfo}}
  \renewcommand{\subjclass}[2][2010]{}
\fi

\ifams 
  \ifninept \PassOptionsToClass{9pt}{amsart} \fi 
  \iftenpt \PassOptionsToClass{10pt}{amsart} \fi 
  \ifelevenpt \PassOptionsToClass{11pt}{amsart} \fi 
  \iftwelvept \PassOptionsToClass{12pt}{amsart} \fi 
  \LoadClass{amsart} 
  \usepackage[colorlinks=true, linkcolor=blue, citecolor=blue, urlcolor=blue]{hyperref}
  
  % Dummy commands for things used by GT style
  \newcommand{\givenname}[1]{}
  \newcommand{\surname}[1]{}
  \newcommand{\arxivreference}[1]{}
  \newcommand{\arxivpassword}[1]{}
  \newcommand{\subject}[3]{}
  \newcommand{\keyword}[1]{}
\fi

%%% Set font %%% 
\iftimes
   \ifgt \relax \else 
   \usepackage{mathptmx} 
   \usepackage{mathrsfs}
\fi \fi

\ifutopia \usepackage{fourier} \fi

\iflucida 
  \ifgt 
  \let\digamma\undefined
  \fi 
  \usepackage[lucidasmallscale, nofontinfo]{lucimatx}
\fi


%%% Macros for formating:

% Strip off the margins for onscreen viewing

\let\trimpdfpages\undefined
\newcommand{\trimpdfpages}[1]{%
\let\remnantmargin\undefined
\newcommand{\remnantmargin}{#1}

% First move the PDF origin to the upper-left
% corner of the text

\setlength{\pdfhorigin}{-\oddsidemargin}
\addtolength{\pdfhorigin}{-\hoffset}

\setlength{\pdfvorigin}{-\topmargin}
\addtolength{\pdfvorigin}{-\voffset}

% Now trim to the minimal page size
\setlength{\pdfpagewidth}{\textwidth}
\setlength{\pdfpageheight}{\textheight}

\addtolength{\pdfpageheight}{\headsep}
\addtolength{\pdfpageheight}{\headheight}
\addtolength{\pdfpageheight}{\footskip}

% Now pad out to the desired margins
\addtolength{\pdfhorigin}{\remnantmargin}
\addtolength{\pdfpagewidth}{\remnantmargin}
\addtolength{\pdfpagewidth}{\remnantmargin}

\addtolength{\pdfvorigin}{\remnantmargin}
\addtolength{\pdfpageheight}{\remnantmargin}
\addtolength{\pdfpageheight}{\remnantmargin}
}
\newcommand{\trimpages}[1]{%
   \AtBeginDocument{\trimpdfpages{#1}}
}

% Format for printing on US Letter pages

\newcommand{\printing}[1]{%
  \setlength{\textwidth}{#1\textwidth}
  \setlength{\textheight}{1.5\textwidth}
  \trimpages{0.3cm}
}

\newcommand{\laptop}{%
  \setlength{\textheight}{1.2\textwidth}
  \trimpages{0.5cm}
}



%%% Graphics 
\usepackage{graphicx, color}
\usepackage[all,import,rotate]{xy}
\usepackage[margin=15pt,font=small,labelfont=bf, labelsep=period]{caption}
\usepackage[margin=15pt,font=small,labelfont=bf, labelsep=period]{subfig}

% Nathan's basic label overlay environment.   The usual version is the second one
% below.  Args are: coor system, graphics modifiers, graphics name

\newenvironment{xyoverpic}[3]
{%
\begin{xy}
\xyimport#1{\includegraphics[#2]{#3}}
}{\end{xy}}

\newenvironment{cxyoverpic}[3]
{%
\begin{center}
\centering\leavevmode\small
\begin{xyoverpic}{#1}{#2}{#3}
}{\end{xyoverpic}
\end{center}}

%%% Bibilography

\usepackage{ragged2e}
\ifgt
% gtpart hardwires the max width of a biblabel, so we rewire it manually.  
\makeatletter
\def\thebibliography#1 {\@thebibliography@{999999}\small\parskip0pt 
plus2pt\relax\addcontentsline{toc}{section}{Bibliography}}
\makeatother 
\fi

%% For the MathReview links 
\def\MR#1{\href{http://www.ams.org/mathscinet-getitem?mr=#1}{MR#1}}
\def\checkMR MR#1#2#3 #4\relax%
  {\ifx#1M%
     \ifx#2R\MR{#3}\else\MR{#1#2#3}\fi
   \else
     \MR{#1#2#3}%
   \fi}
\def\mathreviewsnumber#1{\checkMR MR#1 \relax}


%%% Setup Theorems

% Theorem definitions
%\newtheoremstyle{plain}{}{}{\slshape}{}{\bfseries}{.}{0.5em}{}
\theoremstyle{plain}
\swapnumbers
\newtheorem{theorem}[subsection]{Theorem}
\newtheorem{conjecture}[subsection]{Conjecture}
\newtheorem{lemma}[subsection]{Lemma}
\newtheorem{corollary}[subsection]{Corollary}
\newtheorem{proposition}[subsection]{Proposition}
\newtheorem{claim}[subsection]{Claim}
\newtheorem{question}[subsection]{Question}
\newtheorem{criterion}[subsection]{Criterion}
\newtheorem{project}[subsection]{Project}

\theoremstyle{definition}
\newtheorem{definition}[subsection]{Definition}
\newtheorem{notation}[subsection]{Notation}

\theoremstyle{remark}
\newtheorem{remark}[subsection]{Remark}
\newtheorem{example}[subsection]{Example}

\theoremstyle{plain}

% Change enum to use letters, so there's no confusion with equation labels.

\renewcommand{\labelenumi}{(\alph{enumi}) }
\renewcommand{\theenumi}{\alph{enumi}}

% I want subsections and theorems to be numbered on the same counter,
% E.g.  Section 1, Subsection 1.1, Lemma 1.2, Theorem 1.3, Subsection
% 1.4, etc. There ought to be a better way to equate two counters
% than this, but...

\makeatletter
  \let\c@figure=\c@subsection
  \let\thefigure=\thesubsection
  \let\c@table=\c@subsection
  \let\thetable=\thesubsection
  \let\c@equation=\c@subsection
  \let\theequation=\thesubsection
\makeatother

%%% Change float params as per TeX FAQ to make things more 
%%% flexible 

\renewcommand{\topfraction}{.85}
\renewcommand{\bottomfraction}{.7}
\renewcommand{\textfraction}{.15}
\renewcommand{\floatpagefraction}{.66}
\renewcommand{\dbltopfraction}{.66}
\renewcommand{\dblfloatpagefraction}{.66}
\setcounter{topnumber}{9}
\setcounter{bottomnumber}{9}
\setcounter{totalnumber}{20}
\setcounter{dbltopnumber}{9}

% The following allows hyphenation in the word 3-manifold, but not
% on the hyphen itself

\newcommand{\hyp}{\nobreakdash-\hspace{0pt}}
\newcommand{\3}[1]{3\hyp}

% Show current page layout using \layout

\usepackage{layout}

%%% Marking future tasks. 

\newcommand{\todo}[1]{\textcolor{red}{\emph{#1}}}

%%% Standard Math commands

%% Black Board Bold Letters

\def\Q{{\mathbb Q}}
\def\R{{\mathbb R}}
\def\C{{\mathbb C}}
\newcommand{\T}{{\mathbb T}}
\def\Z{{\mathbb Z}}
\newcommand{\E}{{\mathbb E}}
\newcommand{\F}{{\mathbb F}}
\newcommand{\N}{{\mathbb N}}
\renewcommand{\H}{{\mathbb H}}
\newcommand{\CH}{{\mathbb{CH}}}

%% macros for things

\newcommand{\maps}{\colon\thinspace}
\newcommand{\SL}[2]{\mathrm{ SL}_{#1} #2}
\newcommand{\PSL}[2]{\mathrm{PSL}_{#1} #2}
\newcommand{\GL}[2]{\mathrm{GL}_{#1} #2}
\newcommand{\PGL}[2]{\mathrm{PGL}_{#1} #2}
\newcommand{\RP}{{{\mathbb{R}}\,\mathrm{P}}}
\newcommand{\CP}{{{\mathbb{C}}\,\mathrm{P}}}
\DeclareMathOperator{\rank}{rank}
\DeclareMathOperator{\Aut}{Aut}
\DeclareMathOperator{\Out}{Out}
\DeclareMathOperator{\Hom}{Hom}
\DeclareMathOperator{\Gal}{Gal}
\DeclareMathOperator{\tr}{tr}
\DeclareMathOperator{\vol}{vol}
\DeclareMathOperator{\Vol}{Vol}
\DeclareMathOperator{\Isom}{Isom}

\newcommand{\norm}[1]{{\left\| #1 \right\|}}
\newcommand{\abs}[1]{{\left| #1 \right|}}
\newcommand{\pair}[1]{\left\langle #1 \right\rangle}
\newcommand{\setdef}[2]{{  \left\{  {#1}  \ \left| \   {#2} \right. \right\} }}
\newcommand{\setdefm}[3]{{  #1\{  {#2}  \ #1 | \   {#3}  #1\} }}
\newcommand{\spandef}[2]{{  \left\langle  {#1}  \ \left| \   {#2} \right. \right\rangle }}

\newcommand{\mysmallmatrix}[4]{\left(\begin{smallmatrix}
        \scriptstyle #1 & \scriptstyle #2  \\ \scriptstyle #3 &
        \scriptstyle #4
        \end{smallmatrix}\right)
}
\newcommand{\mtext}[1]{\quad \mbox{#1} \quad}

% Better overlines and tildes.  Example of useage
% \newcommand{\barN}{\kernoverline{4}{N}{1}} 
% here first number shifts the overline to the right and the second
% number shortens it somewhat.


\newcommand{\kernoverline}[3]{{\mkern #1mu\overline{\mkern-#1mu #2\mkern-#3mu}\mkern#3mu}}
\newcommand{\kerntilde}[3]{{\mkern #1mu\widetilde{\mkern-#1mu #2\mkern-#3mu}\mkern#3mu}}
\newcommand{\kernhat}[3]{{\mkern #1mu\widehat{\mkern-#1mu #2\mkern-#3mu}\mkern#3mu}}

\newcommand{\doublequom}[5]{{\raisebox{-#4}{$#1$}}#5\backslash {\raisebox{#4}{$#2$}}#5 / {\raisebox{-#4}{$#3$}}}
\newcommand{\doublequo}[3]{\doublequom{#1}{#2}{#3}{4pt}{\big}}
% other quotient constructions
\newcommand{\rightquom}[4]{{\raisebox{#3}{$#1$}}#4/ {\raisebox{-#3}{$#2$}}}
\newcommand{\leftquom}[4]{{\raisebox{-#3}{$#1$}}#4\backslash{\raisebox{#3}{$#2$}
}}
\newcommand{\doublerightquom}[4]{{\raisebox{#3}{$#1$}}#4/ \! \, \! #4/ {\raisebox{-#3}{$#2$}}}

