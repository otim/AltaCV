%%%%%%%%%%%%%%%%%
% This is altacv.cls (v1.1.3, 30 April 2017) written by
% LianTze Lim (liantze@gmail.com).
%
%% It may be distributed and/or modified under the
%% conditions of the LaTeX Project Public License, either version 1.3
%% of this license or (at your option) any later version.
%% The latest version of this license is in
%%    http://www.latex-project.org/lppl.txt
%% and version 1.3 or later is part of all distributions of LaTeX
%% version 2003/12/01 or later.
%%%%%%%%%%%%%%%%
\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{altacv}[2017/04/30 AltaCV v1.1.3, yet another alternative class for a résumé/curriculum vitae.]

%% v1.1: Optionally load academicons
\newif\if@academicons
\DeclareOption{academicons}{\@academiconstrue}
%% v1.1.3: Choice of round/square photo
\newif\if@normalphoto
\DeclareOption{normalphoto}{\@normalphototrue}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{extarticle}}
\ProcessOptions\relax

\LoadClass{extarticle}

\RequirePackage[margin=2cm]{geometry}
\RequirePackage{fontawesome}

%% v1.1: Optionally load academicons
\if@academicons
  %% Patch to make academicons compilable with XeLaTeX
  \ExplSyntaxOn
  \msg_redirect_name:nnn { fontspec } { font-not-found } { none }
  \ExplSyntaxOff
  \RequirePackage{academicons}
  \newfontfamily{\AI}{academicons.ttf}
\fi

\RequirePackage{xcolor}

\colorlet{accent}{blue!70!black}
\colorlet{heading}{black}
\colorlet{emphasis}{black}
\colorlet{body}{black!80!white}
\newcommand{\itemmarker}{{\small\textbullet}}
\newcommand{\ratingmarker}{\faCircle}

\RequirePackage{tikz}
\usetikzlibrary{arrows,arrows.meta}
\RequirePackage[skins]{tcolorbox}
\tcbuselibrary{breakable}
\RequirePackage{enumitem}
\setlist{leftmargin=*,labelsep=0.5em,nosep,itemsep=0.25\baselineskip,after=\vskip0.25\baselineskip}
\setlist[itemize]{label=\itemmarker}
\RequirePackage{graphicx}
\RequirePackage{etoolbox}
\RequirePackage{dashrule}
\RequirePackage{multirow,tabu}
\RequirePackage{changepage}
\RequirePackage{colortbl}
\RequirePackage{refcount}
% \RequirePackage{marginfix}

\setlength{\parindent}{0pt}
\newcommand{\divider}{\textcolor{body!20}{\hdashrule{\linewidth}{0.6pt}{0.5ex}}\medskip}

\newenvironment{fullwidth}{%
  \begin{adjustwidth}{}{\dimexpr-\marginparwidth-\marginparsep\relax}}
  {\end{adjustwidth}}

\newcommand{\emailsymbol}{\faAt}
\newcommand{\phonesymbol}{\faPhone}
\newcommand{\skypesymbol}{\faSkype}
\newcommand{\homepagesymbol}{\faChain}
\newcommand{\locationsymbol}{\faMapMarker}
\newcommand{\linkedinsymbol}{\faLinkedin}
\newcommand{\twittersymbol}{\faTwitter}
\newcommand{\githubsymbol}{\faGithub}
\newcommand{\orcidsymbol}{\aiOrcid}
\newcommand{\mailsymbol}{\faEnvelope}

\newcommand{\printinfo}[2]{\mbox{\textcolor{accent}{#1}\hspace{0.5em}#2}}

\newcommand{\name}[1]{\def\@name{#1}}
\newcommand{\tagline}[1]{\def\@tagline{#1}}
\newcommand{\photo}[2]{\def\@photo{#2}\def\@photodiameter{#1}}
\newcommand{\email}[1]{\printinfo{\emailsymbol}{#1}}
\newcommand{\mailaddress}[1]{\printinfo{\mailsymbol}{#1}}
\newcommand{\phone}[1]{\printinfo{\phonesymbol}{#1}}
\newcommand{\skype}[1]{\printinfo{\skypesymbol}{#1}}
\newcommand{\homepage}[1]{\printinfo{\homepagesymbol}{#1}}
\newcommand{\twitter}[1]{\printinfo{\twittersymbol}{#1}}
\newcommand{\linkedin}[1]{\printinfo{\linkedinsymbol}{#1}}
\newcommand{\github}[1]{\printinfo{\githubsymbol}{#1}}
\newcommand{\orcid}[1]{\printinfo{\orcidsymbol}{#1}}
\newcommand{\location}[1]{\printinfo{\locationsymbol}{#1}}

\newcommand{\personalinfo}[1]{\def\@personalinfo{#1}}

\definecolor{myblue}{RGB}{0,100,200}
\definecolor{mygray}{RGB}{200,200,200}

\newcommand{\makesidebar}[3]{
\begin{minipage}{#1\pagewidth}
  \vskip -1.5mm%should make sure the page is filled from top to bottom
  \begingroup
  \begin{tcolorbox}[height fill=maximum,size=normal,%oversize
    sharp corners,%
    colback=mygray,%
    colframe=mygray,%
    width=\dimexpr #1\pagewidth \relax,%
    boxsep=#2]
  \label{#3}
  \ifnum\getpagerefnumber{#3}=1% Only insert the image on the first page.
    \ifdef{\@photodiameter}{
    \begin{center}
    \begin{minipage}{\@photodiameter}{}
    \if@normalphoto
      \includegraphics[width=\linewidth]{\@photo}
    \else
      \tikz\path[fill overzoom image={\@photo}]circle[radius=0.5\linewidth];
    \fi
    \end{minipage}
    \end{center}
    }{}
  \else\fi
  \input{#3}
  \end{tcolorbox}
  \endgroup
\end{minipage}
}

\newcommand{\makecvheader}{%
  \vskip -1.5mm%should make sure the page is filled from top to bottom
  \begingroup
    \begin{tabu} to \linewidth {X[11,r,b]|X[9,l,b]}
    \color{emphasis}%
    {\LARGE\fontseries{sb}\selectfont\MakeUppercase{\@name}}%
    \ifdef{\@tagline}{\large\par\itshape\fontseries{l}\selectfont\color{accent}\@tagline}{}%
    &
    \footnotesize\@personalinfo
    \end{tabu}
  \endgroup\par
}

\newcommand{\makemainbar}[3]{%
  \begingroup
  \begin{minipage}{#1\pagewidth}
  \begin{tcolorbox}[height fill=maximum,size=normal,%
    sharp corners,%
    colback=white,%
    colframe=white,%
    width=\dimexpr #1\pagewidth \relax,%
    boxsep=#2]%
  \label{#3}
  \ifnum\getpagerefnumber{#3}=1% Only insert the header on the first page.
    \makecvheader%
    \medskip
  \else\fi
  \input{#3}
  \end{tcolorbox}
  \end{minipage}
  \endgroup
}

\renewenvironment{quote}{\color{accent}\itshape\large}{\par}

\newcommand{\cvsection}[2]{%
  \bigskip
  {\tabulinesep=1.2mm
  \begin{tabu} to \linewidth {X[1,c,m]X[12,l,m]}
  \arrayrulecolor{heading}\cline{2-2}
  \Large\color{heading}#1
  & \color{heading}\Large\bfseries\MakeUppercase{#2}
  \\\cline{2-2}
  \end{tabu}}%
  \medskip
}

\newcommand{\cvsubsection}[1]{%
  \medskip
  \color{heading}\large\bfseries\MakeUppercase{#1}
  \\\arrayrulecolor{heading}\cline{2-2}%
  & \medskip
}

\newenvironment{cvsectionindent}{
  \tabulinesep=1.2mm
  \begin{tabu} to \linewidth {X[1,c,m]X[12,j,m]}
  &
}
{
  \\ \end{tabu}
}

\newcommand\tikzmark[1]{\tikz[remember picture,overlay] \coordinate (#1);}
\newenvironment{cvsectiontimeline}{
  \tabulinesep=1.2mm
  \begin{tabu} to \linewidth {X[1,c,m]X[12,j,m]}
  \tikzmark{a} & \\
}
{
  \end{tabu}
  \tikz[remember picture,overlay]{\draw [-{Latex[length=3mm]}] ([yshift=-2.5ex]b) -- ([yshift=-1ex]a);}
}

\newcommand{\cvsectiontimelineitem}[4]{% This is similar to cvevent but intended to be used in the cvtimeline environment
  \tikzmark{b} & \\
  \faCircle & {\color{emphasis}#1} \\
  &
  {\itshape\fontseries{sb}\selectfont\large\color{emphasis}#2}\par
  \medskip
  {\small\makebox[0.5\linewidth][l]{\faCalendar \hspace{0.5em}\parbox{0.5\linewidth}{#3}}%
  \smallskip
  \ifstrequal{#4}{}{}{\makebox[0.5\linewidth][l]{\faMapMarker\hspace{0.5em}\parbox{0.5\linewidth}{#4}}}} \\
}

\newcommand{\cvevent}[4]{%
  {\color{emphasis}#1\par}
  \medskip
  {\itshape\fontseries{sb}\selectfont\large\color{emphasis}#2}\par
  \medskip
  {\small\makebox[0.5\linewidth][l]{\faCalendar \hspace{0.5em}\parbox{0.5\linewidth}{#3}}%
  \ifstrequal{#4}{}{}{\makebox[0.5\linewidth][l]{\faMapMarker\hspace{0.5em}\parbox{0.5\linewidth}{#4}}}\par}
  \medskip
}

\newcommand{\cvachievement}[3]{%
  {\tabulinesep=1.2mm
  \begin{tabu} to \linewidth {X[1,r,b]X[12,j,b]}
  \color{accent}#1 & \bfseries\textcolor{emphasis}{#2} \\
  & #3 \\
  \end{tabu}}
  \smallskip
}

\newcommand{\cvtag}[1]{%
  \tikz[baseline]\node[anchor=base,draw=body!20,rounded corners,inner xsep=1ex,inner ysep =0.75ex,text height=1.5ex,text depth=.25ex]{#1};
}

\newcommand{\cvskill}[2]{%
\textcolor{emphasis}{#1}\hfill
\foreach \x in {1,...,5}{%
  \space{\ifnumgreater{\x}{#2}{\color{body!20}}{\color{accent}}\faCircle}}\par%
}

% Adapted from @Jake's answer at http://tex.stackexchange.com/a/82729/226
\newcommand{\wheelchart}[3]{%
    \begingroup\centering
    \def\innerradius{#2}%
    \def\outerradius{#1}%
    % Calculate total
    \pgfmathsetmacro{\totalnum}{0}%
    \foreach \value/\colour/\name in {#3} {%
        \pgfmathparse{\value+\totalnum}%
        \global\let\totalnum=\pgfmathresult%
    }%
    \begin{tikzpicture}

      % Calculate the thickness and the middle line of the wheel
      \pgfmathsetmacro{\wheelwidth}{\outerradius-\innerradius}
      \pgfmathsetmacro{\midradius}{(\outerradius+\innerradius)/2}

      % Rotate so we start from the top
      \begin{scope}[rotate=-90]

      % Loop through each value set. \cumnum keeps track of where we are in the wheel
      \pgfmathsetmacro{\cumnum}{0}
      \foreach \value/\width/\colour/\name in {#3} {
            \pgfmathsetmacro{\newcumnum}{\cumnum + \value/\totalnum*360}

            % Calculate the percent value
            \pgfmathsetmacro{\percentage}{\value/\totalnum*100}
            % Calculate the mid angle of the colour segments to place the labels
            \pgfmathsetmacro{\midangle}{-(\cumnum+\newcumnum)/2}

            % This is necessary for the labels to align nicely
            \pgfmathparse{
               (-\midangle>180?"west":"east")
            } \edef\textanchor{\pgfmathresult}
            \pgfmathparse{
               (-\midangle>180?"flush left":"flush right")
            } \edef\textalign{\pgfmathresult}
            \pgfmathsetmacro\labelshiftdir{1-2*(-\midangle<180)}

            % Draw the color segments. Somehow, the \midrow units got lost, so we add 'pt' at the end. Not nice...
            \filldraw[draw=white,fill=\colour] (-\cumnum:\outerradius) arc (-\cumnum:-(\newcumnum):\outerradius) --
            (-\newcumnum:\innerradius) arc (-\newcumnum:-(\cumnum):\innerradius) -- cycle;

            % Draw the data labels
            \draw  [*-,thin,emphasis] node [append after command={(\midangle:\midradius pt) -- (\midangle:\outerradius + 1ex) -- (\tikzlastnode)}] at (\midangle:\outerradius + 1ex) [xshift=\labelshiftdir*0.5cm,inner sep=1ex, outer sep=0pt, text width=\width,anchor=\textanchor,align=\textalign,font=\small,text=body]{\name};
            % Set the old cumulated angle to the new value
            \global\let\cumnum=\newcumnum
        }
      \end{scope}
%      \draw[gray] (0,0) circle (\outerradius) circle (\innerradius);
    \end{tikzpicture}\par
    \endgroup
}

\newcommand{\cvref}[4]{%
  \smallskip
  \textcolor{emphasis}{\textbf{#1}}\par
  \smallskip
  \begin{description}[font=\color{accent},style=multiline,leftmargin=1.25em]
  \item[\small\faBriefcase] #2
  \item[\emailsymbol] #3
  \ifstrequal{#4}{}{}{\item[\phonesymbol] #4}
  \end{description}
%   \medskip
}

\RequirePackage[backend=biber,style=authoryear,sorting=ydnt]{biblatex}
%% For removing numbering entirely when using a numeric style
% \setlength{\bibhang}{1em}
% \DeclareFieldFormat{labelnumberwidth}{\makebox[\bibhang][l]{\itemmarker}}
% \setlength{\biblabelsep}{0pt}
\renewcommand{\bibsetup}{\vspace*{-\baselineskip}}
\AtEveryBibitem{\makebox[\bibhang][l]{\itemmarker}}
\setlength{\bibitemsep}{0.25\baselineskip}

% v1.1.2: make it easier to add a sidebar aligned with top of next page
\RequirePackage{afterpage}
\newcommand{\addsidebar}[2][]{\marginpar{%
  \ifstrequal{#1}{}{}{\vspace*{#1}}%
  \input{#2}}%
}
\newcommand{\addnextpagesidebar}[2][]{\afterpage{\addsidebar[#1]{#2}}}

\AtBeginDocument{%
  \pagestyle{empty}
  \color{body}
}
