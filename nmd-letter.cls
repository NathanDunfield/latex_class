\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{nmd-letter}[2014/08/31 - Semester start edition]
\RequirePackage{nmdmisc}
\newif\ifnologo
\newif\iftimes
\newif\ifutopia
\newif\iflucida
\newif\ifcm
\DeclareOption{nologo}{\nologotrue}
\DeclareOption{times}{\timestrue}
\DeclareOption{utopia}{\utopiatrue}
\DeclareOption{lucida}{\lucidatrue}
\PassDownOptionToPackage{tikz}{nmdgraphics}
\PassDownOptionToPackage{xy}{nmdgraphics}
\ProcessOptions

\LoadClassWithOptions{article} 
\RequirePackage{nmdgraphics}
\usepackage{amsmath, amssymb, amsthm}
\RequirePackage{nmdthm}

\usepackage[colorlinks=true, linkcolor=blue, citecolor=blue, urlcolor=blue]{hyperref}
\usepackage[margin=1in]{geometry}
\setlength{\parindent}{0pt}
\setlength{\parskip}{1.5ex}

\pagestyle{empty}
\thispagestyle{empty}

% Make the default font Utopia 
\iflucida \relax \else \iftimes \relax \else \utopiatrue \fi \fi 

\iftimes
   \usepackage{mathptmx} 
   \usepackage{mathrsfs}
\fi 

\ifutopia \usepackage{fourier} \fi

\iflucida 
  \let\digamma\undefined
  \usepackage[lucidasmallscale, nofontinfo]{lucimatx}
\fi

\RequirePackage{nmdmath}

%%% Special letter stuff

\def\returnaddress{Department of Mathematics \\
  273 Altgeld Hall, MC-382 \\
  1409 W. Green Street \\ 
  Urbana, IL 61801}
\definecolor{uiucblue}{cmyk}{1.0,0.72,0,0.32}
\def\fromaddress{\textcolor{uiucblue}{\returnaddress}}
\def\datebox{\vbox to 0.75in{\hsize=2in \vfill\hfill \today\vfill}}
\def\completeaddress{\vbox to 0.75in{\hsize=2in \vfill\fromaddress \vfill}}

\ifnologo
  \def\logo{\null\vspace{30pt}\centerline{\hfill \datebox}}
\else 
  \def\logo{
  \null\vspace{-60pt}\begingroup
  \centerline{\includegraphics{full_mark_vert_bold}}
  \vspace{10pt}
  \centerline{\completeaddress \hfill \datebox}
  \endgroup\par}
\fi

% Code specific to letters.

\newcommand{\opening}[2]{\logo
  
  \vspace{2ex}
  
  #1

  \vspace{1ex}

  #2

  \vspace{1ex}
  
  }

\ifnologo
  \def\signature{\vspace{0.915in}}
\else 
  \def\signature{\hspace{-1.5cm}\includegraphics[scale=0.4]{nathand}}
\fi

\newcommand{\closing}{

\vspace{0.5cm}

\hspace{2in}
\begin{minipage}[b]{3in}
Sincerely, 

\signature

Nathan M. Dunfield 

\vspace{2ex}

Associate Professor \\
University of Illinois
\end{minipage}
}
