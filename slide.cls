% Nathan's slide class
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{nmd/slide}[2015/03/08 - Stuck at ORD edition]

\RequirePackage{nmd/common}
\RequirePackage{expl3}
\RequirePackage{xkeyval}
\newif\ifnmdslide@half
\newif\ifnmdslide@morethanhalf
\DeclareOption{half}{\nmdslide@halftrue}
\DeclareOption{morethanhalf}{\nmdslide@morethanhalftrue}
\DeclareOptionX{aspect}{\def\nmdslide@aspect{#1}}
\DeclareOptionX{hmargin}{\def\nmdslide@hmargin{#1}}
\DeclareOptionX{vmargin}{\def\nmdslide@vmargin{#1}}
\PassDownOptionToPackage{tikz}{nmd/graphics}
\PassDownOptionToPackage{xy}{nmd/graphics}
\ExecuteOptionsX{aspect=4:3, hmargin=0.5cm, vmargin=0cm}
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
    \setlength{\nmdslide@width}{15.2cm}
}
\ifthen{\equal{\nmdslide@aspect}{16:9}}{
    \setlength{\nmdslide@width}{16.8888889cm}
}

\ifnmdslide@half
\setlength{\nmdslide@width}{0.5\nmdslide@width}
\fi

\ifnmdslide@morethanhalf
  % In 4:3 mode, morethanhalf results in a slide width of 7.5cm
  \ifthen{\equal{\nmdslide@aspect}{4:3}}{
    \setlength{\nmdslide@width}{0.592105\nmdslide@width}
  }
\fi


\geometry{papersize={\nmdslide@width, \nmdslide@height},     hmargin=\nmdslide@hmargin, vmargin=\nmdslide@vmargin}



\RequirePackage{nmd/fonts}
\RequirePackage{nmd/graphics}
\RequirePackage{nmd/math}
\graphicspath{{images/}}
