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
%   * custom look: utopia (default), times, stix, lucida. 
%   * ams look: computer modern (default), utopia, times, stix, lucida.
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
%  
%  Formating commands:
%    \trimpages, \laptop, \printing

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{nmd/article}[2014/08/31 - Semester start edition]
\RequirePackage{etex}
\RequirePackage{nmd/common}

%%% Setup options

\newif\ifgt
\newif\ifams
\newif\ifcustom
\DeclareOption{gt}{\gttrue}
\DeclareOption{ams}{\amstrue}
\DeclareOption{custom}{\customtrue}
\PassDownOptionToPackage{xy}{nmd/graphics}
\PassDownOptionToPackage{tikz}{nmd/graphics}
\PassDownOptionToPackage{times}{nmd/fonts}
\PassDownOptionToPackage{stix}{nmd/fonts}
\PassDownOptionToPackage{utopia}{nmd/fonts}
\PassDownOptionToPackage{lucida}{nmd/fonts}
\PassDownOptionToPackage{sepfignums}{nmd/thm}
\PassDownOptionToPackage{defaultenums}{nmd/thm}

% The GT style has a fixed size font, but the AMS and custom ones
% doesn't.  

\PassDownOptionToClass{9pt}{amsart}
\PassDownOptionToClass{10pt}{amsart}
\DeclareOption{11pt}{\PassOptionsToClass{11pt}{amsart}%
          \PassOptionsToClass{11pt}{nmd/custom}}
\DeclareOption{12pt}{\PassOptionsToClass{12pt}{amsart}%
           \PassOptionsToClass{12pt}{nmd/custom}}
\ProcessOptions

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

  \RequirePackage{tocloft}
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
  \RequirePackage[colorlinks=true, linkcolor=blue, citecolor=blue,
  urlcolor=blue]{hyperref}
\fi

%% Custom Style
\ifcustom
  \LoadClassWithOptions{nmd/custom}
\fi 

%%% Set font %%% 
\RequirePackage{nmd/fonts}

% Dummy commands for things used by GT style
\providecommand{\givenname}[1]{}
\providecommand{\surname}[1]{}
\providecommand{\arxivreference}[1]{}
\providecommand{\arxivpassword}[1]{}
\providecommand{\subject}[3]{}
\providecommand{\keyword}[1]{}

%%% Change float params to make things more flexible
\nmd@freefloats


%%% For the bibilography
\RequirePackage{ragged2e}
%%% For the MathReview links 

\def\MR#1{\href{http://www.ams.org/mathscinet-getitem?mr=#1}{MR#1}}
\def\checkMR MR#1#2#3 #4\relax%
  {\ifx#1M%
     \ifx#2R\MR{#3}\else\MR{#1#2#3}\fi
   \else
     \MR{#1#2#3}%
   \fi}
\def\mathreviewsnumber#1{\checkMR MR#1 \relax}

\RequirePackage{nmd/graphics}
\RequirePackage{nmd/thm}
\RequirePackage{nmd/math}

 % End of nmd article class