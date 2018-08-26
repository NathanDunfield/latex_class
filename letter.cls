\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{nmd/letter}[2014/08/31 - Semester start edition]
\RequirePackage{nmd/common}
\newboolean{nologo}
\DeclareOption{nologo}{\nologotrue}
\newboolean{signature}
\DeclareOption{signature}{\signaturetrue}
\PassDownOptionToPackage{times}{nmd/fonts}
\PassDownOptionToPackage{stix}{nmd/fonts}
\PassDownOptionToPackage{utopia}{nmd/fonts}
\PassDownOptionToPackage{lucida}{nmd/fonts}
\PassDownOptionToPackage{tikz}{nmd/graphics}
\PassDownOptionToPackage{xy}{nmd/graphics}
\ProcessOptions
\LoadClassWithOptions{article} 

\RequirePackage{nmd/graphics}
\RequirePackage{amsmath, amssymb, amsthm}
\RequirePackage{nmd/thm}
\RequirePackage[colorlinks=true, linkcolor=blue, citecolor=blue, urlcolor=blue]{hyperref}
\RequirePackage[margin=1in]{geometry}
\RequirePackage{nmd/fonts}
\RequirePackage{nmd/math}

%%% Special letter stuff

\setlength{\parindent}{0pt}
\setlength{\parskip}{1.5ex}
\pagestyle{empty}
\thispagestyle{empty}

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
  \signaturetrue
\fi

\ifsignature
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

Professor of Mathematics \\
University of Illinois
\end{minipage}
}

\newcommand{\pompousclosing}{

\vspace{0.5cm}

\hspace{2in}
\begin{minipage}[b]{4in}
Sincerely, 

\signature

Nathan M. Dunfield 

\vspace{2ex}

Professor of Mathematics \\
University of Illinois \\
\\ 
Fellow of the American Mathematical Society (inducted 2013) \\
Former Simons Fellow (2013--14) and Sloan Fellow (2004--08) \\
LAS Dean's award for undergraduate teaching (2014) \\ 
web: http://dunfield.info 
\end{minipage}
}

\newcommand{\somewhatpompousclosing}{

\vspace{0.5cm}

\hspace{2in}
\begin{minipage}[b]{4in}
Sincerely, 

\signature

Nathan M. Dunfield 

\vspace{2ex}

Professor of Mathematics \\
University of Illinois \\
\\ 
Fellow of the American Mathematical Society \\
\\
web: http://dunfield.info 
\end{minipage}
}



\newcommand{\basicclosing}{

\vspace{0.5cm}

\hspace{2in}
\begin{minipage}[b]{4in}
Sincerely, 

\signature

Nathan M. Dunfield 
\end{minipage}
}
