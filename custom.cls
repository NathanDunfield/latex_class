%%% Core of NMD's custom style.  
%
% Inspired by Hatcher's "Algebraic Topology" and it is quickly
% recognized as such by mathematicians despite only copying two
% features (and those in modified form): the section headers and
% vertical decoration next to theorems-type statements.

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{nmd/custom}[2014/08/31 - Semester start edition]
\RequirePackage{nmd/common}
\newboolean{fullpage}
\newboolean{fatpage}
\newboolean{grant}
\newboolean{address} \addresstrue
\newboolean{smalltitle}
\newboolean{elevenpt}
\newboolean{twelvept}
\DeclareOption{11pt}{\elevenpttrue \PassOptionsToClass{11pt}{article}}
\DeclareOption{fullpage}{\fullpagetrue}
\DeclareOption{fatpage}{\fatpagetrue}
\DeclareOption{grant}{\granttrue}
\DeclareOption{noaddress}{\addressfalse}
\DeclareOption{smalltitle}{\smalltitletrue}
\ProcessOptions

%%% make 12 point the default
\ifnotthen{\boolean{elevenpt}}{%
   \twelvepttrue
   \PassOptionsToClass{12pt}{article}
}

%%% Load base: LaTeX's article class
\LoadClass{article}
   
 %%% Set page size
\RequirePackage{calc}
\newlength{\nmdwidth}
\newlength{\nmdhmargins}
\setlength{\nmdwidth}{410bp}
\setlength{\nmdhmargins}{45bp}

\iffullpage
   \RequirePackage[paper=letterpaper, hmarginratio=1:1, top=1.5\nmdhmargins, 
                textwidth=\nmdwidth, textheight=1.4\nmdwidth, 
                headsep=10bp, headheight=15bp]{geometry}
\fi

\iffatpage
   \RequirePackage[paper=letterpaper, hmarginratio=1:1, top=1.65\nmdhmargins, 
                 textwidth=1.1\nmdwidth, textheight=1.55\nmdwidth, 
                 headsep=10bp, headheight=15bp]{geometry}
\fi

\ifgrant
    \RequirePackage[paper=letterpaper, margin=1in]{geometry}
\fi

\ifnotthen{\boolean{fullpage} \or \boolean{fatpage} \or \boolean{grant}}{%
    \RequirePackage[papersize={\nmdwidth+2\nmdhmargins,
         1.33\nmdwidth+2.66\nmdhmargins}, hmarginratio=1:1,
         top=0.85\nmdhmargins, textwidth=\nmdwidth,
         textheight=1.4\nmdwidth, headsep=10bp, headheight=15bp]{geometry}
    }

%%% Section formating code
%
% First, load a nice sans-serif font

\RequirePackage[scaled]{berasans}
\newcommand{\nmd@setarticlefonts}[4]{
   \DeclareFixedFont{\sectionfont}{T1}{fvs}{b}{n}{#1}
   \DeclareFixedFont{\titlefont}{T1}{fvs}{b}{n}{#2}
   \DeclareFixedFont{\authorfont}{T1}{fvs}{m}{it}{#3}
   \DeclareFixedFont{\dedicationfont}{T1}{fvs}{m}{it}{#4}
}

% Load section formatting package 

\RequirePackage[medium]{titlesec}

\newcommand{\nmd@settitlebar}[2]{
  \newcommand{\titlebar}{%
    \setlength{\fboxsep}{0bp}%
    \colorbox{nmdlight}{\vphantom{\rule[#1]{0bp}{#2}}%    
            \hspace{\dimexpr\linewidth-2\fboxsep}}%
    \hspace*{-\textwidth}%
    \hspace{0.5em}\thesection %
  }
}


% Set things up depending on the font size
\ifelevenpt
   \nmd@settitlebar{-7bp}{23bp}
   \ifsmalltitle
      \nmd@setarticlefonts{13.5bp}{18bp}{14bp}{10bp}
    \else 
       \nmd@setarticlefonts{13.5bp}{22bp}{16bp}{10bp}
    \fi
\else % twelve point
    \nmd@settitlebar{-10bp}{30bp}
    \ifsmalltitle
      \nmd@setarticlefonts{15bp}{20bp}{15bp}{11bp}
    \else 
       \nmd@setarticlefonts{15bp}{24bp}{18bp}{11bp}
    \fi
\fi 
   
% Rest of of (sub)section formating
\titleformat{\section}[hang]{\sectionfont}{\titlebar}{0.7em}{}[]
\titlespacing*{\section}{0pt}{3ex}{2ex}
\titlespacing{\subsection}{0ex}{1.5ex}{0.5em}
\titleformat{\subsection}[runin]{\normalsize\bfseries}{\thesubsection}{0.35em}{}[.]
   
%%% Set the page headers
  
\RequirePackage{fancyhdr}
\pagestyle{fancy}

% Clear everthing 
\lhead{} \chead{} \rhead{} \lfoot{} \rfoot{} \cfoot{}
\renewcommand{\headrulewidth}{0pt}

\ifgrant 
   \cfoot{\thepage}
\else
   \lhead{\small \hrulefill\hspace{0.5em}\raisebox{-0.6ex}{\thepage}\hspace{0.5em}\hrulefill}
\fi 
 


%%% AMS Maths 

\RequirePackage{amsmath, amssymb}
   
   

%%% Theorems

\RequirePackage{amsthm}
\RequirePackage{thmtools}
\newtheoremstyle{plain}{}{}{\slshape}{0pt}{\bfseries}{.}{0.5em}{}

% make spacing after theorem number match section style
\def\swappedhead#1#2#3{%
    \thmnumber{\@upn{\the\thm@headfont#2\@ifnotempty{#1}{\hspace{0.35em}}}}%
\thmname{#1}%
\thmnote{ {#3}}}

% Add the rule on the left
\RequirePackage{settobox}
\newsavebox{\nmdparasavebox}
\newlength{\nmdparaboxheight}

\newenvironment{leftruledparagraph}[3]{% Env. start code
  \def\nmdparaboxrule{#1} %
  \def\nmdparaboxspace{#2} %
  \def\nmdparaboxcolor{#3} %
  \begin{lrbox}{\nmdparasavebox}%
  \begin{minipage}[b]{\textwidth - #1 - #2}}%
{% Env. end code
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
} % end def of leftruledparagraph
   
\define@key{thmdef}{nmd}[{}]{%
  \thmt@trytwice{}{%
    \addtotheorempreheadhook[\thmt@envname]{%
      \begin{leftruledparagraph}{3bp}{6bp}{nmdmedium}}}
    {%
      \addtotheorempostfoothook[\thmt@envname]{%
      \end{leftruledparagraph}}
  }
}


%%% Title/author/address code is so bad it had to hide elsewhere:
\RequirePackage{nmd/title}

\newcommand{\keywords}[1]{}
\newcommand{\subjclass}[2][2010]{}

%%% Hyperref with dark links for better printing.  
\RequirePackage[colorlinks=true, linkcolor=nmddark,
         citecolor=nmddark,urlcolor=nmddark]{hyperref}