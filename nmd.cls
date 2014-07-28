%%% Nathan M. Dunfield's personal LaTeX class %%%
%
%  Main options: gt, ams, custom
%  Font options: times, utopia, lucida
%  
%  Formating commands:
%    \trimpages, \laptop, \printing

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{nmd}[2012/03/25 - Spring Break Blahs Edition]
\usepackage{etex}

%%% Setup options

\newif\ifgt
\newif\ifams
\newif\ifcustom
\newif\iftimes
\newif\ifutopia
\newif\iflucida
\newif\ifcm
\newif\ifninept
\newif\iftenpt
\newif\ifelevenpt
\newif\iftwelvept
\newif\iffullpage
\newif\iffatpage
\newif\ifgrant
\newif\ifaddress \addresstrue
\newif\ifsmalltitle 
\newif\ifxy
\DeclareOption{gt}{\gttrue}
\DeclareOption{ams}{\amstrue}
\DeclareOption{custom}{\customtrue}
\DeclareOption{times}{\timestrue}
\DeclareOption{utopia}{\utopiatrue}
\DeclareOption{lucida}{\lucidatrue}
\DeclareOption{cm}{\cmtrue}
\DeclareOption{fullpage}{\fullpagetrue}
\DeclareOption{fatpage}{\fatpagetrue}
\DeclareOption{grant}{\granttrue}
\DeclareOption{noaddress}{\addressfalse}
\DeclareOption{smalltitle}{\smalltitletrue}
\DeclareOption{xy}{\xytrue}

% The GT style has a fixed font, but the AMS and custom ones doesn't.  
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

%%%  Make the custom style the default
\customtrue
\ifams \customfalse \fi
\ifgt \customfalse \fi

%%% Load basic style file %%% 

\ifgt
 \LoadClass[microtype]{gtpart} 
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
  \usepackage[colorlinks=true, linkcolor=blue, citecolor=blue,
  urlcolor=blue]{hyperref}
\fi

% Dummy commands for things used by GT style
\ifgt \relax \else
  \newcommand{\givenname}[1]{}
  \newcommand{\surname}[1]{}
  \newcommand{\arxivreference}[1]{}
  \newcommand{\arxivpassword}[1]{}
  \newcommand{\subject}[3]{}
  \newcommand{\keyword}[1]{}
\fi

%%% Core of custom style %%% 

\ifcustom
   \ifelevenpt 
     \PassOptionsToClass{11pt}{article} 
    \else
      \PassOptionsToClass{12pt}{article}
   \fi
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

   % Make the default font Utopia 
   \iflucida \relax \else \iftimes \relax \else \utopiatrue \fi \fi 

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
   
   % colors
   \usepackage{xcolor}
   \definecolor{nmdlight}{cmyk}{0.128, 0.176, 0.0, 0.0}
   \definecolor{nmdmedium}{cmyk}{0.41, 0.49, 0.06, 0.0}
   \definecolor{nmddark}{rgb}{0.1, 0.0, 0.5}
   
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
\fi

%%% Set font %%% 
%
%  Assumes we will use CM only if it is the default 
%  font for a particular class. 

\iftimes
   \ifgt \relax \else 
   \usepackage{mathptmx} 
   \usepackage{mathrsfs}
\fi \fi

\ifutopia \usepackage{fourier} \fi

\iflucida 
  \let\digamma\undefined
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
  \setlength{\textheight}{1.1\textwidth}
  \trimpages{0.5cm}
}

\newcommand{\bigmonitor}{%
  \setlength{\textheight}{1.7\textwidth}
  \trimpages{0.5cm}
}




%%% Bibilography

\usepackage{ragged2e}
\ifgt
% gtpart hardwires the max width of a biblabel, so we rewire it manually.  
\def\thebibliography#1 {\@thebibliography@{999999}\small\parskip0pt 
plus2pt\relax\addcontentsline{toc}{section}{Bibliography}}
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

% Theorem definitions.  Note tried to get cleveref to work,
% but proved too flaky to be worth it.  

\ifcustom \relax \else
   \usepackage{thmtools}
   \define@key{thmdef}{nmd}[{}]{}
\fi   

\usepackage{thm-restate}
\swapnumbers

\ifams
   \newtheoremstyle{plain}{}{}{\slshape}{}{\bfseries}{.}{0.5em}{}
\fi
  
\newcommand{\nmdnewtheorem}[1]{%
  \declaretheorem[nmd, style=plain, sibling=subsection]{#1}}

\nmdnewtheorem{theorem}
\nmdnewtheorem{conjecture}
\nmdnewtheorem{lemma}
\nmdnewtheorem{corollary}
\nmdnewtheorem{proposition}
\nmdnewtheorem{claim}
\nmdnewtheorem{question}
\nmdnewtheorem{goal}
\nmdnewtheorem{criterion}
\nmdnewtheorem{project}

\declaretheorem[style=definition, sibling=subsection]{definition}
\declaretheorem[style=definition, sibling=subsection]{notation}
\declaretheorem[style=remark, sibling=subsection]{remark}
\declaretheorem[style=remark, sibling=subsection]{example}


% Change enum to use letters, so there's no confusion 
% with equation labels.  I'm not really happy with this. 

\renewcommand{\labelenumi}{(\alph{enumi}) }
\renewcommand{\theenumi}{\alph{enumi}}

%%% Graphics 
\usepackage{graphicx, color}
\usepackage{tikz}
\usetikzlibrary{positioning}
\usetikzlibrary{calc}
\usepackage{booktabs}
\usepackage[margin=15pt,font=small,labelfont=bf, labelsep=period]{caption}
\usepackage[margin=15pt,font=small,labelfont=bf,
labelsep=period]{subfig}

% Put figures, tables, and equations onto the common
% subsection/theorem counter. There ought to be a better 
% way to equate two counters than this, but...

\let\c@figure=\c@subsection
\let\thefigure=\thesubsection
\let\c@table=\c@subsection
\let\thetable=\thesubsection
\let\c@equation=\c@subsection
\let\theequation=\thesubsection


% Nathan's basic label overlay environment.   The usual version is the second one
% below.  Args are: coor system, graphics modifiers, graphics name

\ifxy
  \usepackage[all,import,rotate]{xy}
   \newenvironment{xyoverpic}[3]
    {%
    \begin{xy}
    \xyimport#1{\includegraphics[#2]{#3}}
    }{\end{xy}}
\else \relax \fi 

\newenvironment{cxyoverpic}[3]
{%
\begin{center}
\centering\leavevmode\small
\begin{xyoverpic}{#1}{#2}{#3}
}{\end{xyoverpic}
\end{center}}

% USAGE:  \begin{tikzoverlay}[<graphics opts>]{file name}[tikz opts]
%              (tikz commands in coordinate system where horizontal
%              direction is 100)
%              \end{tikzoverlay}
%
% The variant tikzoverlayabs uses coordinates going from (0,0) to (1,1).
%
% Modeled on 
%
% http://bazaar.launchpad.net/~tex-sx/tex-sx/development/view/head:/onimage.dtx

\def\tikzoverlay{%
    \pgfutil@ifnextchar[{\tikzoverlay@opt}{\tikzoveraly@opt[]}%
}
\def\tikzoverlay@opt[#1]#2{%
    \begin{tikzpicture}
        \node[anchor=south west, inner sep=0] (image) at (0,0) {\includegraphics[#1]{#2}};
        \newdimen\nmd@tikzoverlaywidth
        \pgfextractx{\nmd@tikzoverlaywidth}{\pgfpointanchor{image}{south east}}
        \begin{scope}
          \tikzset{x=0.01\nmd@tikzoverlaywidth}
          \tikzset{y=0.01\nmd@tikzoverlaywidth}
}
\def\endtikzoverlay{%
    \end{scope}
    \end{tikzpicture}
}

\def\tikzoverlayabs{%
    \pgfutil@ifnextchar[{\tikzoverlayabs@opt}{\tikzoveralyabs@opt[]}%
}
\def\tikzoverlayabs@opt[#1]#2{%
    \begin{tikzpicture}
        \node[anchor=south west, inner sep=0] (image) at (0,0) {\includegraphics[#1]{#2}};
        \begin{scope}
          \tikzset{x=(image.south east)}
          \tikzset{y=(image.north west)}
}
\def\endtikzoverlayabs{%
    \end{scope}
    \end{tikzpicture}
}

%%%  Including Matplotlib figures with TikZ overlay 

\pgfkeys{
  /matplotlibfigure/.is family, /matplotlibfigure, 
  default/.style = {width = 0.95\textwidth, font = \footnotesize}, 
  width/.store in = \matplotlibfigurewidth,
  font/.store in = \matplotlibfigurefont,
}

\newcommand{\matplotlibfigure}[2][]{%
 \pgfkeys{/matplotlibfigure, default, #1}%
 \input{plots/#2}
}


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
\let\2\undefined
\newcommand{\2}[1]{2\hyp}

% Show current page layout using \layout

\usepackage{layout}

%%% Marking future tasks. 

\newcommand{\todo}[1]{\textcolor{red}{\emph{#1}}}

%%% Standard Math commands

%% Black Board Bold Letters

\ifgt \relax \else  % The first four are included in the G&T style. 
\newcommand{\Q}{{\mathbb Q}}
\newcommand{\R}{{\mathbb R}}
\newcommand{\C}{{\mathbb C}}
\newcommand{\Z}{{\mathbb Z}}
\fi 
\newcommand{\T}{{\mathbb T}}
\newcommand{\E}{{\mathbb E}}
\newcommand{\F}{{\mathbb F}}
\newcommand{\N}{{\mathbb N}}
\renewcommand{\H}{{\mathbb{H}}}
\newcommand{\CH}{{\mathbb{CH}}}
\newcommand{\RH}{{\mathbb{RH}}}

%% Calligraphic letters

\newcommand{\cA}{{\mathcal A}}
\newcommand{\cB}{{\mathcal B}}
\newcommand{\cC}{{\mathcal C}}
\newcommand{\cD}{{\mathcal D}}
\newcommand{\cE}{{\mathcal E}}
\newcommand{\cF}{{\mathcal F}} 
\newcommand{\cG}{{\mathcal G}}
\newcommand{\cH}{{\mathcal H}}
\newcommand{\cT}{{\mathcal T}}
\newcommand{\cS}{{\mathcal S}}
\newcommand{\cV}{{\mathcal V}}

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
\DeclareMathOperator{\Area}{Area}
\DeclareMathOperator{\Isom}{Isom}
\DeclareMathOperator{\Teich}{Teich}
\DeclareMathOperator{\Homeo}{Homeo}
\DeclareMathOperator{\inj}{inj}
\newcommand{\bdry}{\partial}
\newcommand{\PML}{\mathcal{P \!\!\! M \! L}}
\newcommand{\MCG}{\mathcal{M \! CG}}
\newcommand{\Tor}{\mathcal{T} \!\!\!\! \mathit{or}}
\newcommand{\norm}[1]{{\left\| #1 \right\|}}
\newcommand{\abs}[1]{{\left| #1 \right|}}
\newcommand{\pair}[1]{\left\langle #1 \right\rangle}
\newcommand{\somethingdef}[4]{{\left#1 {#2} \ \left| \ {#3} \vphantom{#2} \right. \right#4}}
\newcommand{\somethingdefm}[5]{{  #1#2  {#3}  \ #1 | \   {#4}  #1#5 }}

\newcommand{\setdef}[2]{\somethingdef{\{}{#1}{#2}{\}}}
\newcommand{\spandef}[2]{\somethingdef{\langle}{#1}{#2}{\rangle}}
\newcommand{\setdefm}[3]{\somethingdefm{#1}{\{}{#2}{#3}{\}}}
\newcommand{\spandefm}[3]{\somethingdefm{#1}{\langle}{#2}{#3}{\rangle}}

\newcommand{\mysmallmatrix}[4]{\left(\begin{smallmatrix}
        \scriptstyle #1 & \scriptstyle #2  \\ \scriptstyle #3 &
        \scriptstyle #4
        \end{smallmatrix}\right)
}
\newcommand{\twobytwomatrix}[4]{\left(\begin{array}{cc}
        #1 & #2  \\  #3 & #4
        \end{array}\right)
}
\newcommand{\mtext}[1]{\quad \mbox{#1} \quad}

\newcommand{\makeassignmacro}[2]{\hspace{#1}\raisebox{#2}{\ensuremath{:}}\hspace{-#1}=}
\newcommand{\assign}{:=}
\ifutopia \renewcommand{\assign}{\makeassignmacro{0.45ex}{0.095ex}} \fi
\iftimes \renewcommand{\assign}{\makeassignmacro{0.5ex}{0.06ex}} \fi
\iflucida \renewcommand{\assign}{\makeassignmacro{0.6ex}{0.046ex}} \fi
\ifcm \renewcommand{\assign}{\makeassignmacro{0.6ex}{0.085ex}} \fi

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

% Standard overlines and tildes.

% New style
\newcommand{\Mtil}{\kerntilde{2}{M}{-1}}
\newcommand{\Ftil}{\kerntilde{2.5}{F}{-1}}
\newcommand{\Stil}{\kerntilde{2.5}{S}{0}}
\newcommand{\Xtil}{\kerntilde{2.5}{X}{0}}
\newcommand{\Ytil}{\kerntilde{2.5}{Y}{0}}
\newcommand{\rhotil}{\kerntilde{2.5}{\rho}{0}}
\newcommand{\Mbar}{\kernoverline{2}{M}{-1}}
\newcommand{\Fbar}{\kernoverline{2.5}{F}{-1}}
\newcommand{\Sbar}{\kernoverline{2.5}{S}{0}}
\newcommand{\Xbar}{\kernoverline{2.5}{X}{0}}
\newcommand{\Ybar}{\kernoverline{2.5}{Y}{0}}
\newcommand{\Tbar}{\kernoverline{2.5}{T}{0}}

% Old style
\newcommand{\tilM}{\kerntilde{2}{M}{-1}}
\newcommand{\tilF}{\kerntilde{2.5}{F}{-1}}
\newcommand{\tilS}{\kerntilde{2.5}{S}{0}}
\newcommand{\tilX}{\kerntilde{2.5}{X}{0}}
\newcommand{\tilY}{\kerntilde{2.5}{Y}{0}}
\newcommand{\tilrho}{\kerntilde{2.5}{\rho}{0}}
\newcommand{\barM}{\kernoverline{2}{M}{-1}}
\newcommand{\barF}{\kernoverline{2.5}{F}{-1}}
\newcommand{\barS}{\kernoverline{2.5}{S}{0}}
\newcommand{\barX}{\kernoverline{2.5}{X}{0}}
\newcommand{\barY}{\kernoverline{2.5}{Y}{0}}
\newcommand{\barT}{\kernoverline{2.5}{T}{0}}

% heegaard floer stuff

\newcommand{\HFhat}{\kernhat{2}{\mathit{HF}\vphantom{\raisebox{0.25pt}{$\mathit{HF}$}}}{-2}}
\newcommand{\HomeoR}{\Homeo^+\!(\R)}
\newcommand{\tilPSLTwoR}{\kerntilde{0}{\PSL{2}{\R}}{0}}


% CSisms:

\renewcommand{\P}{\mathbf{P}}
\newcommand{\NP}{\mathbf{NP}}
\newcommand{\coNP}{\mbox{\textbf{co-NP}}}

% End of nmd class
