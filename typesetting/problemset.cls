%
% Copyright © 2007–2013  Felix Höfling
%
\NeedsTeXFormat{LaTeX2e}[1996/12/01]
\ProvidesClass{problemset}[2013/10/15 v1.9 a class for problemsets]
%
\DeclareOption{a4paper}{\PassOptionsToClass{\CurrentOption}{scrartcl}}
\DeclareOption{11pt}{\PassOptionsToClass{\CurrentOption}{scrartcl}}
\DeclareOption{DIV12}{\PassOptionsToClass{\CurrentOption}{scrartcl}}
\DeclareOption{twoside}{\PassOptionsToClass{\CurrentOption}{scrartcl}}
\DeclareOption{answerdelayed}{\PassOptionsToPackage{\CurrentOption}{exercise}}
\DeclareOption{lastexercise}{\PassOptionsToPackage{\CurrentOption}{exercise}}
\DeclareOption{german}{\PassOptionsToPackage{main=\CurrentOption}{babel}\AtEndOfClass{\main@language{german}}}
\DeclareOption{english}{\PassOptionsToPackage{main=\CurrentOption}{babel}\AtEndOfClass{\main@language{english}}}
\newif\if@prblmst@mtpro\@prblmst@mtprofalse
\DeclareOption{mtpro2}{\@prblmst@mtprotrue}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{scrartcl}%
\PassOptionsToPackage{\CurrentOption}{exercise,graphicx}}
\ExecuteOptions{a4paper,11pt,DIV12,answerdelayed,lastexercise}
\ProcessOptions\relax
\LoadClass{scrartcl}
\RequirePackage{exercise}
%
\RequirePackage[german,english]{babel}
\RequirePackage{scrpage2}
\RequirePackage{graphicx}
\RequirePackage{psfrag,wrapfig,mdwtab,alphalph}
\RequirePackage[inline]{enumitem}
\RequirePackage{url} \urlstyle{same}
% setup fonts
\RequirePackage{cmap} % make ligatures etc. copy- and searchable
\RequirePackage{microtype}
\RequirePackage{amsmath}
\RequirePackage{mleftright}
\IfFileExists{mtpro2.sty}{}{\@prblmst@mtprofalse} % use MTPro2 only if installed
\if@prblmst@mtpro
  \RequirePackage{times}
  \RequirePackage[scaled=.92]{helvet}
  \RequirePackage[mtphrb,mtpcal,mtpfrak,subscriptcorrection,compatiblegreek,slantedGreek,zswash,amssymbols]{mtpro2}
  % redefine environment pmatrix: let \PARENS enclose a matrix environment
  \def\env@pmatrix{\PARENS{\env@matrix}\def\endpmatrix{\endmatrix}}
\else
  \RequirePackage{amssymb,eucal}
  \RequirePackage{txfonts}
  \renewcommand{\rmdefault}{ptm}
\fi
\RequirePackage[T1]{fontenc}
% customize the exercise environment
\newenvironment{tutorial}[1][]{\setcounter{points}{0}\begin{Exercise}[name={Tutorial},#1]}%
  {\addtocounter{totalpoints}{\value{points}}\prblmst@write@points\end{Exercise}}
\newenvironment{problem}[1][]{\setcounter{points}{0}\begin{Exercise}[#1]}%
  {\addtocounter{totalpoints}{\value{points}}\prblmst@write@points\end{Exercise}}
\newenvironment{solution}[1][]{\begin{Answer}[#1]}{\end{Answer}}
\newcommand\question[1][]{\Question[#1]\parindent=1em} % restore parindent
\newcommand\subquestion[1][]{\subQuestion[#1]\parindent=1em} % restore parindent
%
\newcommand\hint[2][\HintName]{\smallskip\par\noindent{\footnotesize\emph{#1:} #2\par}}
%
\newcounter{problemset}
\renewcounter{Exercise}[problemset]
%
\def\ExercisesTitle{\ExercisesTitleName\space\arabic{problemset}}
\def\AnswersTitle{\AnswersTitleName\space\ExercisesTitleName\space\arabic{problemset}}
%
\def\ExercisesTitleName{Problem set}
\def\AnswersTitleName{Solutions to}
\def\ExerciseName{Problem}
\def\AnswerName{Solution to \ExerciseName}
%
\@ifpackageloaded{babel}{
\addto{\captionsenglish}{
  \def\ExercisesTitleName{Problem set}
  \def\AnswersTitleName{Solutions to}
  \def\ExerciseName{Problem}
  \def\AnswerName{Solution to \ExerciseName}
  \def\DueDateName{Due date}
%
  \def\ExerciseListName{Ex.}%
  \def\AnswerListName{Answer}%
  \def\ExePartName{Part}%
  \def\HintName{Hint}%
}}{}
\@ifpackageloaded{babel}{
\addto{\captionsgerman}{
  \def\ExercisesTitleName{{\"U}bungsblatt}%
  \def\AnswersTitleName{L{\"o}sungen zu}%
  \def\AnswerName{L{\"o}sung zu \ExerciseName}%
  \def\DueDateName{Abgabetermin}
%
  \def\ExerciseName{Aufgabe}%
  \def\ExerciseListName{Aufg.}%
  \def\AnswerListName{Lsg.}%
  \def\ExePartName{Teil}%
  \def\HintName{Hinweis}%
}}{}
% define some macros to set up header
\def\reader#1{\gdef\@reader{#1}}
\def\@reader{\@latex@error{No \noexpand\reader given}\@ehc}
\def\address#1{\gdef\@address{#1}}
\def\@address{} % not mandatory
\def\assistant#1{\gdef\@assistant{\noexpand #1}}
\def\@assistant{} % not mandatory
\let\assistent\assistant % backwards compatibility
\def\logo#1{\gdef\@logo{#1}}
% \newcommand\logo[1]{\gdef\@logo{#1}}
\def\@logo{} % not mandatory
%
\def\semester#1{\gdef\@semester{#1}}
\def\@semester{\@latex@error{No \noexpand\semester given}\@ehc}
\def\duedate#1{\gdef\@duedate{#1}}
\def\@duedate{\@latex@error{No \noexpand\duedate given}\@ehc}
% specifiy points
\newcounter{points}
\newcounter{totalpoints}
\newcommand\points[1]{\addtocounter{points}{#1}%
  \linebreak[3]\llap{}\hfill\mbox{\bfseries\footnotesize(\prblmst@print@points{#1})}\ignorespaces}
%
\newcommand\prblmst@print@points[1]{%
  \ifnum#1>0 #1~\ifnum#1=1 \PointName\else\PointsName\fi\fi}
\def\prblmst@write@points{\immediate\write\@auxout{\string\newlabel{points@\theExercise}{{\arabic{points}}{\thepage}}}}
\def\@setref@points#1#2#3{%
  \ifx#1\relax\z@\else\expandafter#2#1\fi}
\def\ref@points#1{\expandafter\@setref@points\csname r@points@#1\endcsname\@firstoftwo{points@#1}}
%mbox
\def\PointName{point}
\def\PointsName{points}
\@ifpackageloaded{babel}{
\addto{\captionsgerman}{
  \def\PointName{Punkt}
  \def\PointsName{Punkte}
}}{}
%
\AtBeginDocument{\if@ExerciseOutput\maketitle\fi}
\AtEndDocument{\if@ExerciseOutput\ifx\@duedate\empty\else\par\vfill{\slshape\noindent\DueDateName: \@duedate}\fi\fi%
\if@AnswerOutput{\@twosidetrue\cleardoublepage}\maketitle*\shipoutAnswer\fi}
%
\renewenvironment{titlepage}{\expandafter\if@ExerciseOutput\thispagestyle{empty}}%
{\cleardoublepage\setcounter{page}{1}\expandafter\fi}
%
\renewcommand{\theExercise}{\arabic{problemset}.\arabic{\@ExerciseCounter}}
\renewcommand{\ExerciseHeader}{\subsection*{\ExerciseName~%
  \ExerciseHeaderNB\ExerciseHeaderDifficulty\normalfont\textsl{\ExerciseHeaderTitle%
  \if\ExerciseOrigin\empty\else\ExerciseHeaderOrigin\fi%
  \ifnum\ref@points{\theExercise}>0 \hfill(\prblmst@print@points{\ref@points{\theExercise}})\fi}}}
\renewcommand{\AnswerHeader}{\subsection*{\AnswerName~%
  \ExerciseHeaderNB\ExerciseHeaderDifficulty\normalfont\textsl{\ExerciseHeaderTitle%
  \if\ExerciseOrigin\empty\else\ExerciseHeaderOrigin\fi}}}
\renewcommand\QuestionHeaderDifficulty{}
\renewcommand{\QuestionNB}{\alphalph{\value{Question}}\theQuestionDifficulty)}
\renewcommand{\subQuestionNB}{(\roman{subQuestion})}
% typeset a figure or table caption without a figure/table environment
\newcommand*\figurecaption{\def\@captype{figure}\captionbelow}
\newcommand*\tablecaption{\def\@captype{table}\captionbelow}
\setcapindent{\z@}
%
% some more look&feel
\setkomafont{sectioning}{\bfseries}
\addtokomafont{caption}{\footnotesize}
\setkomafont{captionlabel}{\bfseries}
\def\figurename{Fig.}
\addto{\captionsenglish}{
  \def\figurename{Fig.}
}
\fboxsep=0.5em
% setup header from \@logo, \@semester, \@title, \@reader, \@assistant, \@address
\newif\if@solution\@solutionfalse
\renewcommand\maketitle{\@ifstar{\@solutiontrue\@maketitle}{\@maketitle}}
\def\@maketitle{\if@solution\pagestyle{plain}\else\pagestyle{empty}\fi\c@page=1%
% set logo in box with zero height
\setbox\@tempboxa\vbox{\hfill\@logo}\ht\@tempboxa=\z@\box\@tempboxa
\noindent{\bfseries\@reader}\\ {\@assistant \vskip 0pt}\bigskip\par%
% note: the vskip triggers the typesetting the assistants (possibly containing
% line breaks) before resetting the font size
\ifx\@address\empty\else\@address\bigskip\\\fi%
\large\noindent{\bfseries\@title}\hfill{\bfseries\@semester}\\%
\rule[.5\baselineskip]{\textwidth}{0.5pt} \\%
{\bfseries\if@solution\AnswersTitle\else\ExercisesTitle\fi}\hfill{\bfseries\@date}\normalsize\bigskip\par%
}
%
% total differential
\newcommand\diff{\mathrm{d}}
% print vectors as bold letters, unit vectors with a hat
\if@prblmst@mtpro
%  \renewcommand\vec[1]{\mathrm{\boldsymbol #1}}
  \renewcommand\vec[1]{\boldsymbol{\mathrm{#1}}} % with 'compatiblegreek'
  \newcommand\unitvec[1]{\hat{\vec{#1}}}
\else
  \renewcommand\vec[1]{\boldsymbol{\mathrm{#1}}}
  \newcommand\unitvec[1]{\boldsymbol{\hat{\vec #1}}}
\fi
% dot for scalar products, for backwards compatibility
\newcommand\dotprod{\cdot}
% the constant e (Napier's constant?)
\newcommand\e{\mathrm{e}}
% imaginary unit
\renewcommand\i{\mathrm{i}}
% real and imaginary part
\DeclareMathOperator\Imag{Im}
\DeclareMathOperator\Real{Re}
\DeclareMathOperator\Res{Res}
% vector calculus: grad, div, curl, and rot
\DeclareMathOperator\grad{grad}
\DeclareMathOperator\divergence{div}
\DeclareMathOperator\curl{curl}
\DeclareMathOperator\rot{rot}
