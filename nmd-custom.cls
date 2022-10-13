%%% Core of NMD's custom style.
%
% Inspired by Hatcher's "Algebraic Topology" and it is quickly
% recognized as such by mathematicians despite only copying two
% features (and those in modified form): the section headers and
% vertical decoration next to theorems-type statements.

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{nmd/nmd-custom}[2014/08/31 - Semester start edition]
\RequirePackage{nmd/nmd-common}
\newboolean{fullpage}
\newboolean{fatpage}
\newboolean{grant}
\newboolean{nogeometry}
\newboolean{address} \addresstrue
\newboolean{smalltitle}
\newboolean{elevenpt}
\newboolean{eleventwofivept}
\newboolean{elevenfivept}
\newboolean{elevensevenfivept}
\newboolean{twelvept}
\newboolean{nmd@lineno}
\DeclareOption{11pt}{\elevenpttrue \PassOptionsToClass{11pt}{article}}
\DeclareOption{11.25pt}{\eleventwofivepttrue \PassOptionsToClass{11pt}{article}}
\DeclareOption{11.5pt}{\elevenfivepttrue \PassOptionsToClass{11pt}{article}}
\DeclareOption{11.75pt}{\elevensevenfivepttrue \PassOptionsToClass{12pt}{article}}
\DeclareOption{fullpage}{\fullpagetrue}
\DeclareOption{fatpage}{\fatpagetrue}
\DeclareOption{grant}{\granttrue}
\DeclareOption{nogeometry}{\nogeometrytrue}
\DeclareOption{noaddress}{\addressfalse}
\DeclareOption{smalltitle}{\smalltitletrue}
\DeclareOption{lineno}{\nmd@linenotrue}
\ProcessOptions

%%% make 12 point the default
\ifnotthen{\boolean{elevenpt}\or\boolean{elevenfivept}\or\boolean{eleventwofivept}\or\boolean{elevensevenfivept}}{%
   \twelvepttrue
   \PassOptionsToClass{12pt}{article}
}

%%% Load base: LaTeX's article class
\LoadClass{article}

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

%%% Fine tuning of fonts

\RequirePackage{microtype}

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

\ifnotthen{\boolean{fullpage} \or \boolean{fatpage}
           \or \boolean{grant} \or \boolean{nogeometry}}{%
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


%%% Set things up depending on the font size
%
% The values for 11.25, 11.5, and 11.75 are just the linear
% interpolations between 11 and 12.
%
% 11pt
\ifthen{\boolean{elevenpt}}{
   \nmd@settitlebar{-7bp}{23bp}
   \ifsmalltitle
      \nmd@setarticlefonts{13.5bp}{18bp}{14bp}{10bp}
   \else
      \nmd@setarticlefonts{13.5bp}{22bp}{16.5bp}{10bp}
   \fi
}
% 11.25pt
\ifthen{\boolean{eleventwofivept}}{
   \nmd@settitlebar{-7.75bp}{24.75bp}
   \ifsmalltitle
      \nmd@setarticlefonts{13.875bp}{18.5bp}{14.25bp}{10.25bp}
   \else
      \nmd@setarticlefonts{13.875bp}{22.5bp}{17bp}{10.25bp}
   \fi
}
% 11.5pt
\ifthen{\boolean{elevenfivept}}{
   \nmd@settitlebar{-8.5bp}{26.5bp}
   \ifsmalltitle
      \nmd@setarticlefonts{14.25bp}{19bp}{14.5bp}{10.5bp}
   \else
      \nmd@setarticlefonts{14.25bp}{23bp}{16bp}{10.5bp}
   \fi
}
% 11.75pt
\ifthen{\boolean{elevensevenfivept}}{
   \nmd@settitlebar{-9.25bp}{28.25bp}
   \ifsmalltitle
      \nmd@setarticlefonts{14.625bp}{19.5bp}{14.75bp}{10.75bp}
   \else
      \nmd@setarticlefonts{14.625bp}{23.5bp}{17.5bp}{10.75bp}
   \fi
}
% 12pt
\ifthen{\boolean{twelvept}}{
    \nmd@settitlebar{-10bp}{30bp}
    \ifsmalltitle
      \nmd@setarticlefonts{15bp}{20bp}{15bp}{11bp}
    \else
      \nmd@setarticlefonts{15bp}{24bp}{18bp}{11bp}
    \fi
}

\ifnmd@lineno
\RequirePackage[mathlines]{lineno}
\linenumbers
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


%%% Theorems

\RequirePackage{amsthm}
\RequirePackage{thmtools}
\newtheoremstyle{plain}{}{}{\slshape}{0pt}{\bfseries}{.}{0.5em}{}

% make spacing after theorem number match section style
\def\swappedhead#1#2#3{%
    \thmnumber{\@upn{\the\thm@headfont#2\@ifnotempty{#1}{\hspace{0.35em}}}}%
\thmname{#1}%
\thmnote{ {#3}}}

% Change font on notes when swapped numbers not used (rare)
\def\thmhead@plain#1#2#3{%
  \thmname{#1}\thmnumber{\@ifnotempty{#1}{ }\@upn{#2}}%
  \thmnote{ {#3}}}
\let\thmhead\thmhead@plain

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
\RequirePackage{nmd/nmd-title}

\newcommand{\keywords}[1]{}
\newcommand{\subjclass}[2][2010]{}

%%% Hyperref with dark links for better printing.
\RequirePackage[colorlinks=true, linkcolor=nmddark,
         citecolor=nmddark,urlcolor=nmddark]{hyperref}