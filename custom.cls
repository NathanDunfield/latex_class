%%% Core of NMD's custom style.  
%
% Inspired by Hatcher's "Algebraic Topology" and it is quickly
% recognized as such by mathematicians despite only copying two
% features (and those in modified form): the section headers and
% vertical decoration next to theorems-type statements.

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{nmd/custom}[2014/08/31 - Semester start edition]
\newif\iffullpage
\newif\iffatpage
\newif\ifgrant
\newif\ifaddress \addresstrue
\newif\ifsmalltitle 
\newif\ifelevenpt
\newif\iftwelvept
\newif\smalltitle
\DeclareOption{11pt}{\elevenpttrue \PassOptionsToClass{11pt}{article}}
\DeclareOption{fullpage}{\fullpagetrue}
\DeclareOption{fatpage}{\fatpagetrue}
\DeclareOption{grant}{\granttrue}
\DeclareOption{noaddress}{\addressfalse}
\DeclareOption{smalltitle}{\smalltitletrue}
\ProcessOptions

% make 12 point the default
\ifelevenpt 
   \relax 
\else 
   \twelvepttrue
   \PassOptionsToClass{12pt}{article}
\fi

% Load base: LaTeX's article class
\LoadClass{article}
   
 % Set page size
\usepackage{calc}
\newlength{\nmdwidth}
\newlength{\nmdhmargins}
\setlength{\nmdwidth}{410bp}
\setlength{\nmdhmargins}{45bp}
\iffullpage
      \usepackage[paper=letterpaper, hmarginratio=1:1, top=1.5\nmdhmargins, textwidth=\nmdwidth, textheight=1.4\nmdwidth, headsep=10bp, headheight=15bp]{geometry}
   \else
      \iffatpage
         \usepackage[paper=letterpaper, hmarginratio=1:1, top=1.65\nmdhmargins, textwidth=1.1\nmdwidth, textheight=1.55\nmdwidth, headsep=10bp, headheight=15bp]{geometry}
	 \else
	    \ifgrant
               \usepackage[paper=letterpaper, margin=1in]{geometry}
           \else % The default
       \usepackage[papersize={\nmdwidth+2\nmdhmargins,
         1.33\nmdwidth+2.66\nmdhmargins}, hmarginratio=1:1,
         top=0.85\nmdhmargins, textwidth=\nmdwidth,
         textheight=1.4\nmdwidth, headsep=10bp, headheight=15bp]{geometry}
   \fi \fi \fi 

   % Load a decent sans serif font
   %\usepackage{avant}
   \usepackage[scaled]{berasans}
   \ifelevenpt
      \DeclareFixedFont{\sectionfont}{T1}{fvs}{b}{n}{13.5bp}
      \ifsmalltitle
          \DeclareFixedFont{\titlefont}{T1}{fvs}{b}{n}{18bp}
          \DeclareFixedFont{\authorfont}{T1}{fvs}{m}{it}{14bp}
      \else
          \DeclareFixedFont{\titlefont}{T1}{fvs}{b}{n}{22bp}
          \DeclareFixedFont{\authorfont}{T1}{fvs}{m}{it}{16bp}
       \fi
   \else % Twelve pt
       \DeclareFixedFont{\sectionfont}{T1}{fvs}{b}{n}{15bp}
       \ifsmalltitle
           \DeclareFixedFont{\titlefont}{T1}{fvs}{b}{n}{20bp}
           \DeclareFixedFont{\authorfont}{T1}{fvs}{m}{it}{15bp}
       \else
           \DeclareFixedFont{\titlefont}{T1}{fvs}{b}{n}{24bp}
           \DeclareFixedFont{\authorfont}{T1}{fvs}{m}{it}{18bp}
       \fi 
    \fi
   
   % Hyperref with dark links for better printing.  
   \usepackage[colorlinks=true, linkcolor=nmddark,
         citecolor=nmddark,urlcolor=nmddark]{hyperref}
      
   % Format the sections
   \usepackage[medium]{titlesec}
   \ifelevenpt
      \newcommand{\titlebar}{%
         \setlength{\fboxsep}{0bp}%
         \colorbox{nmdlight}{\hbox to \textwidth{\rule[-7bp]{0bp}{23bp}}}%
         \hspace*{-\textwidth}%
         \hspace{0.5em}\thesection %
         }
       \titleformat{\section}[hang]{\sectionfont}{\titlebar}{0.7em}{}[]
       \titlespacing*{\section}{0pt}{3ex}{2ex}
   \else  % Twelve point
      \newcommand{\titlebar}{%
         \setlength{\fboxsep}{0bp}%
         \colorbox{nmdlight}{\hbox to \textwidth{\rule[-10bp]{0bp}{30bp}}}%
         \hspace*{-\textwidth}%
         \hspace{0.5em}\thesection %
         }
       \titleformat{\section}[hang]{\sectionfont}{\titlebar}{0.7em}{}[]
       \titlespacing*{\section}{0pt}{3ex}{2ex}
   \fi
   
   % Format the subsections
   \titlespacing{\subsection}{0ex}{1.5ex}{0.5em}
   \titleformat{\subsection}[runin]{\normalsize\bfseries}{\thesubsection}{0.35em}{}[.]
   
   % Set the headers

   \usepackage{fancyhdr}
   \pagestyle{fancy}
   \ifgrant 
      \lhead{}
      \chead{}
      \rhead{}
      \lfoot{}
      \cfoot{\thepage}
      \rfoot{}
      \renewcommand{\headrulewidth}{0pt}
   \else
      \lhead{\small \hrulefill\hspace{0.5em}\raisebox{-0.6ex}{\thepage}\hspace{0.5em}\hrulefill}
      \chead{}
      \rhead{}
      \lfoot{}
      \cfoot{}
      \rfoot{}
      \renewcommand{\headrulewidth}{0pt}
   \fi 
   % AMS Maths 
   \usepackage{amsmath, amssymb}
   
   % Theorems
   \usepackage{amsthm}
   \usepackage{thmtools}
   \newtheoremstyle{plain}{}{}{\slshape}{0pt}{\bfseries}{.}{0.5em}{}
   % make spacing after theorem number match section style
   \def\swappedhead#1#2#3{%
      \thmnumber{\@upn{\the\thm@headfont#2\@ifnotempty{#1}{\hspace{0.35em}}}}%
   \thmname{#1}%
   \thmnote{ {#3}}}
   % Add the rule on the left
   \usepackage{settobox}

   \newsavebox{\nmdparasavebox}
   \newlength{\nmdparaboxheight}
   \newenvironment{leftruledparagraph}[3]{%
     \def\nmdparaboxrule{#1} %
     \def\nmdparaboxspace{#2} %
     \def\nmdparaboxcolor{#3} %
     \begin{lrbox}{\nmdparasavebox}%
     \begin{minipage}[b]{\textwidth - #1 - #2}}%
    {%
     \end{minipage}% 
     \end{lrbox}%
     \settoboxheight{\nmdparaboxheight}{\nmdparasavebox}% 
     \addtolength{\nmdparaboxheight}{3bp}
     \begin{trivlist}\item[]% In a trivlist because theorems are in trivlists.
     \textcolor{\nmdparaboxcolor}{%
       \raisebox{-2.5bp}{\rule{\nmdparaboxrule}{\nmdparaboxheight}}%
     }%
     \hspace{\nmdparaboxspace}%
     \usebox{\nmdparasavebox}%
     \end{trivlist}
   }
   
   \define@key{thmdef}{nmd}[{}]{%
   \thmt@trytwice{}{%
     \addtotheorempreheadhook[\thmt@envname]{%
       \begin{leftruledparagraph}{3bp}{6bp}{nmdmedium}}}
     {%
      \addtotheorempostfoothook[\thmt@envname]{%
        \end{leftruledparagraph}}
      }
    }
   % Code for names, title, etc.  Mostly taken from amsart
   % Save the title
     \renewcommand{\title}[2][]{\gdef\@title{#2}}
     % Formating for addresses at the end
     \newcommand{\nmd@author}[1]{#1\par}
     \newcommand{\nmd@address}[1]{#1\par}
     \newcommand{\nmd@email}[1]{email: \texttt{#1}\par}
     \newcommand{\nmd@urladdr}[1]{\url{#1}\par \vspace{10bp}}
     % For combining the authors names, we need this giant mess
     \let\@xp=\expandafter
     \let\@nx=\noexpand
     \long\def\@ifempty#1{\@xifempty#1@@..\@nil}
     \long\def\@xifempty#1#2@#3#4#5\@nil{%
       \ifx#3#4\@xp\@firstoftwo\else\@xp\@secondoftwo\fi}
     \long\def\@ifnotempty#1{\@ifempty{#1}{}}
     \csname newtoks\endcsname\@emptytoks
     \newcommand{\xandlist}[4]{\@andlista{{#1}{#2}{#3}}#4\and\and}
     \def\@andlista#1#2\and#3\and{\@andlistc{#2}\@ifnotempty{#3}{%
         \@andlistb#1{#3}}}
     \def\@andlistb#1#2#3#4#5\and{%
       \@ifempty{#5}{%
         \@andlistc{#2#4}%
       }{%
         \@andlistc{#1#4}\@andlistb{#1}{#3}{#3}{#5}%
       }}
     \let\@andlistc\@iden
     \newcommand{\nxandlist}[4]{%
       \def\@andlistc##1{\toks@\@xp{\the\toks@##1}}%
       \toks@{\toks@\@emptytoks \@andlista{{#1}{#2}{#3}}}%
       \the\@xp\toks@#4\and\and
       \edef#4{\the\toks@}%
       \let\@andlistc\@iden}
     \def\@@and{and}
     \newcommand{\andify}{%
       \nxandlist{\unskip, }{\unskip{} \@@and~}{\unskip, \@@and~}}
     \def\and{\unskip{ }\@@and{ }\ignorespaces}
     % End giant mess

     \let\authors\@empty
     \let\addresses\@empty
     \renewcommand{\author}[2][]{%
       \ifx\@empty\authors
       \gdef\authors{#2}%
       \gdef\addresses{\nmd@author{#2}}
       \else
       \g@addto@macro\authors{\and#2}%
       \g@addto@macro\addresses{\nmd@author{#2}}%
       \fi
     }%
     % Save addresses, emails, and urls.
     \newcommand{\address}[2][]{%
       \g@addto@macro\addresses{\nmd@address{#2}}}
     \newcommand{\email}[2][]{%
       \g@addto@macro\addresses{\nmd@email{#2}}}
     \newcommand{\urladdr}[2][]{%
       \g@addto@macro\addresses{\nmd@urladdr{#2}}}
     % The abstract.  
     \newsavebox\abstractbox
     \renewenvironment{abstract}{%
       \global\setbox\abstractbox=\vtop \bgroup%
        \begin{leftruledparagraph}{3bp}{8bp}{nmdmedium}
        \textbf{Abstract.} }
       {\end{leftruledparagraph}\egroup}

     \def\maketitle{\par
       \@topnum\z@ % this prevents figures from falling at the top of page 
       \thispagestyle{empty}
       
       \

       \vspace{20bp}

       {\titlefont\setlength{\baselineskip}{30bp}
       \noindent
       \@title
       
       }

       \vspace{40bp}
       \noindent
       \andify\authors 
       {\authorfont \authors}
       \vspace{10bp}

       \noindent
       \usebox{\abstractbox}
       }
       \AtEndDocument{%
         \small 
         \interlinepenalty\@M
         \setlength{\parindent}{0pt}
         \ifaddress \addresses \fi
       }

   \newcommand{\keywords}[1]{}
   \newcommand{\subjclass}[2][2010]{}
