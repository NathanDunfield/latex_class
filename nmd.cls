%%% Nathan M. Dunfield's personal LaTeX class %%%
%
% A document class which allows one to easily switch between the AMS,
% Geometry & Topology, and its own custom style (inspired by Hatcher's
% "Algebraic Topology").  In particular, a document that uses this
% style can easily be switched over to either "amsart" or "gtpart"
% with minimal modification.  See "template.tex" a minimal useage
% example.  
%
% Main options: custom (default), gt, ams
%  
% Font options: 
%   * custom look: utopia (default), times, lucida. 
%   * ams look: computer modern (default), utopia, times, lucida.
%   * gt look: times (default and only option).
%  
% Font size options:
%
%  * custom: 12pt (default), 11pt.  
%  * ams look: 9-12pt with 10pt the default.  
%  * gt look: 11pt (default and only option).
%    
% Additional options in the custom look:
% 
%  * fullpage: PDF is full US letter sized.  
%  * fatpage: wider textwidth.  
%  * grant: suitable for NSF grants.  
%  * 
%  Formating commands:
%    \trimpages, \laptop, \printing

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{nmd}[2014/08/31 - Semester start edition]
\usepackage{etex}
\usepackage{nmdmisc}

%%% Setup options

\newif\ifgt
\newif\ifams
\newif\ifcustom
\newif\iftimes
\newif\ifutopia
\newif\iflucida
\newif\ifcm
\DeclareOption{gt}{\gttrue}
\DeclareOption{ams}{\amstrue}
\DeclareOption{custom}{\customtrue}
\DeclareOption{times}{\timestrue}
\DeclareOption{utopia}{\utopiatrue}
\DeclareOption{lucida}{\lucidatrue}
\DeclareOption{cm}{\cmtrue}

\PassDownOptionToPackage{xy}{nmdgraphics}

% The GT style has a fixed size font, but the AMS and custom ones
% doesn't.  

\PassDownOptionToClass{9pt}{amsart}
\PassDownOptionToClass{10pt}{amsart}
\DeclareOption{11pt}{\PassOptionsToClass{11pt}{amsart}%
          \PassOptionsToClass{11pt}{nmdcustom}}
\DeclareOption{12pt}{\PassOptionsToClass{12pt}{amsart}%
           \PassOptionsToClass{12pt}{nmdcustom}}
\ProcessOptions

\PassOptionsToClass{smalltitle}{../nmdcustom}

%%% Switch to turn on Nathan's features if his custom option file exists
\newif\ifnmd
\InputIfFileExists{user-is-nathan-dunfield}{\nmdtrue}{\nmdfalse}

%%% Other people probably don't have the Lucida fonts
\ifnmd \relax \else \iflucida \lucidafalse \utopiatrue \fi \fi

%%%  Make the custom style the default
\customtrue
\ifams \customfalse \fi
\ifgt \customfalse \fi

%%% Load underlying Latex class 

%% G&T Style
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

   % gtpart hardwires the max width of a biblabel, so we rewire it manually.  
   \def\thebibliography#1 {\@thebibliography@{999999}\small\parskip0pt 
   plus2pt\relax\addcontentsline{toc}{section}{Bibliography}}
\fi

%% AMS Style
\ifams 
  \LoadClass{amsart} 
  \usepackage[colorlinks=true, linkcolor=blue, citecolor=blue,
  urlcolor=blue]{hyperref}
\fi

%% Custom Style
\ifcustom
  % Make the default font Utopia 
  \iflucida \relax \else \iftimes \relax \else \utopiatrue \fi \fi 
  \LoadClassWithOptions{nmdcustom}
\fi 

% Dummy commands for things used by GT style
\providecommand{\givenname}[1]{}
\providecommand{\surname}[1]{}
\providecommand{\arxivreference}[1]{}
\providecommand{\arxivpassword}[1]{}
\providecommand{\subject}[3]{}
\providecommand{\keyword}[1]{}

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


%%% For the bibilography
\usepackage{ragged2e}
%%% For the MathReview links 

\def\MR#1{\href{http://www.ams.org/mathscinet-getitem?mr=#1}{MR#1}}
\def\checkMR MR#1#2#3 #4\relax%
  {\ifx#1M%
     \ifx#2R\MR{#3}\else\MR{#1#2#3}\fi
   \else
     \MR{#1#2#3}%
   \fi}
\def\mathreviewsnumber#1{\checkMR MR#1 \relax}
%%% Show current page layout using \layout
\usepackage{layout}

\RequirePackage[tikz]{nmdgraphics}
\RequirePackage{nmdthm}
\RequirePackage{nmdmath}

 % End of nmd class
