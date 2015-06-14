% Nathan's slide class
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{nmd/exam}[2015/03/08 - Stuck at ORD edition]

\RequirePackage{nmd/common}
\RequirePackage{expl3}
\RequirePackage{xkeyval}
\newif\ifnmdslide@half
\DeclareOption{half}{\nmdslide@halftrue}
\DeclareOptionX{aspect}{\def\nmdslide@aspect{#1}}
\PassDownOptionToPackage{tikz}{nmd/graphics}
\PassDownOptionToPackage{xy}{nmd/graphics}
\ExecuteOptionsX{aspect=4:3}
\ProcessOptionsX
\ProcessOptions

%\LoadClass[mathserif]{beamer}
\LoadClass{beamer}
\setbeamertemplate{navigation
  symbols}{\setcounter{page}{\value{framenumber}}}

%\RequirePackage{eulervm}
%\RequirePackage[defaultsans, scale=0.9]{opensans}

%\documentclass{beamer}
\usepackage{libertine}

\newlength{\nmdslide@width}
\newlength{\nmdslide@height}
\setlength{\nmdslide@height}{9.5cm}
\setlength{\nmdslide@width}{12.66667cm}

\ifthen{\equal{\nmdslide@aspect}{16:10}}{
    \setlength{\nmdslide@width}{19cm}
}
\ifthen{\equal{\nmdslide@aspect}{16:9}}{
    \setlength{\nmdslide@width}{16.8888889cm}
}

\ifnmdslide@half
\setlength{\nmdslide@width}{0.5\nmdslide@width}
\fi


\geometry{papersize={\nmdslide@width, \nmdslide@height}, hmargin=0.5cm, vmargin=0cm}



\RequirePackage{nmd/fonts}
\RequirePackage{nmd/graphics}
\RequirePackage{nmd/math}
\graphicspath{{images/}}
