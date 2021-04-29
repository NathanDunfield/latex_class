% Style for overlaying PDF pages with TikZ pictures and similar
% composting tasks.

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{nmd/nmd-overlay}[2016/10/26 - tired midfall edition]
\RequirePackage{nmd/nmd-common}
\ProcessOptions
\LoadClassWithOptions{article} 
\RequirePackage{environ}
\RequirePackage[margin=0pt]{geometry}
\RequirePackage{pdfpages}
\RequirePackage[tikz]{nmd/nmd-graphics}
\RequirePackage[utopia]{nmd/nmd-fonts}
\RequirePackage{nmd/nmd-math}

\pgfkeys{
  /nmd/pdf page overlay/page/.initial=1, 
  /nmd/pdf page overlay/file/.initial=No file given
}

% Create a boolean pgfkey and set to false.  
\newif\ifnmd@pageoverlay@showgrid
\pgfkeys{/nmd/pdf page overlay/grid/.is if=nmd@pageoverlay@showgrid}
\pgfkeys{/nmd/pdf page overlay/grid=false}

\NewEnviron{tikzpageoverlay}[1][]{%
  \pgfkeys{/nmd/pdf page overlay/.cd, #1}
  \includepdf[ 
      pages=\pgfkeysvalueof{/nmd/pdf page overlay/page}, 
      pagecommand={
        \begin{tikzpicture}[overlay, remember picture, 
           shift={(current page.north west)}]
          \coordinate (NW) at (current page.north west);
          \coordinate (NE) at (current page.north east);
          \coordinate (SW) at (current page.south west);
          \coordinate (SE) at (current page.south east);
          \BODY
          \ifnmd@pageoverlay@showgrid
              \draw[color=blue!30, step=5cm] (SW) grid (NE);
              \draw[color=blue!30, dashed, step=1cm] (SW) grid (NE);
          \fi
        \end{tikzpicture}}]%
      {\pgfkeysvalueof{/nmd/pdf page overlay/file}}
}     
     
        
