\NeedsTeXFormat{LaTeX2e}

\ProvidesClass{cekmitlprojectreport}

\LoadClass[a4paper, oneside]{book}
\RequirePackage[top=1in, bottom=1in, left=1.5in, right=1in]{geometry}
\RequirePackage{fontspec}
\RequirePackage[fontsize=16pt]{fontsize}
\RequirePackage{xunicode}
\RequirePackage{xltxtra}
\RequirePackage{textpos}
\RequirePackage{lmodern}
\RequirePackage{ragged2e}
\RequirePackage{babel}
\babelprovide[main, import]{thai}
\RequirePackage{titlesec}
\RequirePackage{indentfirst}
\RequirePackage{enumitem}
\RequirePackage{tabularx}
\RequirePackage{colortbl}
\RequirePackage{caption}
\RequirePackage{float}
\RequirePackage{calc}
\RequirePackage{graphicx}
\graphicspath{ {./images/} }
\RequirePackage{fancyhdr}
\RequirePackage{titletoc}
\RequirePackage{ifthen}
\RequirePackage{lineno}
\RequirePackage{soul}
\RequirePackage{amsmath}
\RequirePackage{natbib}
\RequirePackage{etoolbox}
\usepackage[normalem]{ulem}
\RequirePackage[strict]{changepage}
\RequirePackage{listings}


% ## Centering all floating objects (inc. figures) ##
\makeatletter
\g@addto@macro\@floatboxreset\centering
\makeatother

\setlength{\floatsep}{20pt}

\setcounter{secnumdepth}{3}


% ## Dot Fill ##
\makeatletter
\newcommand \DotFill {\leavevmode \cleaders \hb@xt@ .22em{\hss .\hss }\hfill \kern \z@}
\makeatother


% ## Fonts ##
\XeTeXlinebreaklocale "th_TH"
\XeTeXlinebreakskip = 0pt plus 1pt
\linespread{1.0}

\setmainfont{Angsana New}[
	Path = fonts/angsana-new/,
	UprightFont = ANGSA.ttf,
	ItalicFont = ANGSAI.ttf,
	BoldFont = angsab.ttf,
	BoldItalicFont = AngsanaNewBoldItalic.ttf,
	Script=Thai
]

\newfontfamily{\monofont}[
	Path = fonts/inconsolata/,
	BoldFont = Inconsolata-Bold.ttf
]{Inconsolata-Regular.ttf}

\setlength{\parindent}{35pt}
\newlength\parindentvalue
\setlength\parindentvalue{\parindent}

% ## Header & Footer ##
\pagestyle{empty}
\setlength{\headheight}{20pt}
\fancypagestyle{preamble}{
	\renewcommand{\thepage}{\MakeUppercase{\roman{page}}}
    \fancyhf{}
    \fancyfoot[C]{\thepage}
	\renewcommand{\headrulewidth}{0pt}
}

\fancypagestyle{toc}{
	\fancyhf{}
	\renewcommand{\headrulewidth}{0pt}
}

\fancypagestyle{maincontent}{
	\renewcommand{\thepage}{\arabic{page}}
    \fancyhf{}
    \fancyhead[R]{\thepage}
	\renewcommand{\headrulewidth}{0pt}
	\setlength{\parindent}{\parindentvalue}
}

\fancypagestyle{plain}{
  \fancyhf{}
}

% ## Table of Contents Format ##
% อ้างอิงจาก http://kt-linux.blogspot.com/2011/01/latex.html
% ตั้งค่าความลึกของหน้าสารบัญใหม่เป็น 1 (คือลงลึกแค่ชั้นเดียว) และตั้งค่าคำสั่ง \tableofcontents ใหม่
\setcounter{tocdepth}{2}

\makeatletter
\renewcommand\tableofcontents{
	\addcontentsline{toc}{preamble}{สารบัญ}
    \begin{center}
        {\fontsize{24pt}{1em}\selectfont\textbf{สารบัญ} }
    \end{center}
	\vspace{20pt}
    \begin{flushright}
        \textbf{หน้า}
    \end{flushright}
    % Hold current page value
    % for TOC heading
	\raggedright
    \newcounter{tocitem}
    \setcounter{tocitem}{0}
    \modulolinenumbers[50]
    \linenumbers[1]
    \@starttoc{toc}
    \setcounter{tocitem}{0}
	\nolinenumbers
    \clearpage
    \cleardoublepage
}
\makeatother

% สร้างคำสั่งใหม่สำหรับตรวจสอบว่าบรรทัดปัจจุบัน หรือ จำนวนหัวข้อที่แสดงในสารบัญเกินค่าทึ่กำหนดหรือยัง
% หากเกินแล้วให้ตัดขึ้นหน้าใหม่ รีเซตตัวนับ tocitem รีเซตตัวนับบรรทัดใหม่
% และเขียนหัวของหน้าสารบัญใหม่ (เช่น สารบัญ (ต่อ) ในกรณีนี้)
\newcommand{\tocheadcont}[3]{
    \ifthenelse{#1>27 \OR #2>27}{
        %Should be a newpage here.
        \pagebreak[4]
        \resetlinenumber[1]
        \setcounter{tocitem}{0}
        \begin{center}
            {\fontsize{24pt}{1em}\selectfont\textbf{#3 (ต่อ)} }
        \end{center}  \vskip2em
        \begin{flushright}
            \textbf{หน้า}
        \end{flushright}
    }{}
}


% ## List of Table Format ##
\makeatletter
\renewcommand\listoftables{
	\addcontentsline{toc}{preamble}{สารบัญตาราง}
    \begin{center}
        {\fontsize{24pt}{1em}\selectfont\textbf{สารบัญตาราง} }
    \end{center}
	\vspace{20pt}
	\begin{flushleft}
        \textbf{ตาราง}\hfill\textbf{หน้า}
    \end{flushleft}
	\raggedright
    \newcounter{lotitem}
    \setcounter{lotitem}{0}
    \modulolinenumbers[50]
    \linenumbers[1]
    \@starttoc{lot}
    \setcounter{lotitem}{0}
	\nolinenumbers
    \clearpage
    \cleardoublepage
}
\makeatother

\newcommand{\lotheadcont}[3]{
    \ifthenelse{#1>31 \OR #2>31}{
        \pagebreak[4]
        \resetlinenumber[1]
        \setcounter{lotitem}{0}
        \begin{center}
            {\fontsize{24pt}{1em}\selectfont\textbf{#3 (ต่อ)} }
        \end{center}
		\vspace{20pt}
		\begin{flushleft}
			\textbf{ตาราง}\hfill\textbf{หน้า}
		\end{flushleft}
    }{}
}

% ## List of Figures Format ##
\makeatletter
\renewcommand\listoffigures{
	\addcontentsline{toc}{preamble}{สารบัญรูป}
    \begin{center}
        {\fontsize{24pt}{1em}\selectfont\textbf{สารบัญรูป} }
    \end{center}
	\vspace{20pt}
	\begin{flushleft}
        \textbf{รูป}\hfill\textbf{หน้า}
    \end{flushleft}
    \newcounter{lofitem}
    \setcounter{lofitem}{0}
    \modulolinenumbers[50]
    \linenumbers[1]
    \@starttoc{lof}
    \setcounter{lofitem}{0}
	\nolinenumbers
    \clearpage
    \cleardoublepage
}
\makeatother

\newcommand{\lofheadcont}[3]{
    \ifthenelse{#1>31 \OR #2>31}{
        \pagebreak[4]
        \resetlinenumber[1]
        \setcounter{lofitem}{0}
        \begin{center}
            {\fontsize{24pt}{1em}\selectfont\textbf{#3 (ต่อ)} }
        \end{center}
		\vspace{20pt}
		\begin{flushleft}
			\textbf{รูป}\hfill\textbf{หน้า}
		\end{flushleft}
    }{}
}

% ## Math Format ##
\DeclareMathSizes{16}{12}{10}{8}
\makeatletter
\g@addto@macro\normalsize{%
  \setlength\abovedisplayskip{20pt}
  \setlength\belowdisplayskip{20pt}
  \setlength\abovedisplayshortskip{0pt}
  \setlength\belowdisplayshortskip{20pt}
}
\makeatother


% ## TOC / LOF / LOT Format ##
% tocitem format for chapter
\titlecontents{chapter}[0mm]
{\vspace{20pt}\stepcounter{tocitem}\tocheadcont{\thelinenumber}{\thetocitem}{สารบัญ}}
{\makebox[\parindentvalue][l]{บทที่\hspace{1ex}\thecontentslabel}}
{}{\DotFill\contentspage}

% tocitem format for section
\titlecontents{section}[0mm]
{\leftskip=\parindentvalue\stepcounter{tocitem}\tocheadcont{\thelinenumber}{\thetocitem}{สารบัญ}}
{\makebox[\parindentvalue][l]{\thecontentslabel}}
{}
{\DotFill\contentspage}

% tocitem format for subsection
\titlecontents{subsection}[0mm]
{\leftskip=2.54cm\stepcounter{tocitem}\tocheadcont{\thelinenumber}{\thetocitem}{สารบัญ}}
{\makebox[\parindentvalue][l]{\thecontentslabel}}
{}
{\DotFill\contentspage}

% tocitem format for preamble
\titlecontents{preamble}[0mm]
{\stepcounter{tocitem}\tocheadcont{\thelinenumber}{\thetocitem}{สารบัญ}}
{\makebox[\parindentvalue][l]{\thecontentslabel}}
{}{\DotFill\contentspage}

% lotitem format for table

\titlecontents{table}[0mm]
{\stepcounter{lotitem}\lotheadcont{\thelinenumber}{\thelotitem}{สารบัญตาราง}}
{\makebox[10mm][l]{\thecontentslabel}}
{}{\DotFill\contentspage}

% lotitem format for figure
\titlecontents{figure}[0mm]
{\stepcounter{lofitem}\lofheadcont{\thelinenumber}{\thelofitem}{สารบัญรูป}}
{\makebox[10mm][l]{\thecontentslabel}}
{}{\DotFill\contentspage}


% chapter spacing format for lot and lof
\makeatletter
% \patchcmd{<cmd>}{<search>}{<replace>}{<succes>}{<failure>}
\patchcmd{\@chapter}{\addtocontents{lof}{\protect\addvspace{10\p@}}}{}{}{}% LoF
\patchcmd{\@chapter}{\addtocontents{lot}{\protect\addvspace{10\p@}}}{}{}{}% LoT
\makeatother



% ## Section Format ##
% chapter
\titleformat{\chapter}[display]
{\bfseries\centering\fontsize{20pt}{1em}\selectfont}
{บทที่ \thechapter}{0pt}{\vspace{10pt}\fontsize{24pt}{1em}\selectfont}
\titlespacing*{\chapter}{0pt}{0pt}{20pt}

% section
\titleformat{\section}
{\bfseries\fontsize{18pt}{1em}\selectfont}
{\makebox[\parindentvalue][l]{\thesection}}{0pt}{}
\titlespacing*{\section}{0pt}{20pt}{10pt}

% subsection
\titleformat{\subsection}
{\bfseries\fontsize{16pt}{1em}\selectfont}
{\hspace{\parindentvalue}\makebox[\parindentvalue][l]{\thesubsection}}{0pt}{}
\titlespacing*{\subsection}{0pt}{20pt}{0pt}

% subsubsection
\titleformat{\subsubsection}
{\bfseries\fontsize{16pt}{1em}\selectfont}
{\hspace{2\parindentvalue}\makebox[\parindentvalue][l]{\thesubsubsection}}{0pt}{}
\titlespacing*{\subsubsection}{0pt}{20pt}{0pt}

\makeatletter
\let\xsection\section
\def\section{\par
  \setlength{\leftmargin}{0pt}
  \leftskip\leftmargin
  \@totalleftmargin\leftmargin\linewidth\textwidth
  \xsection}
\let\xsubsection\subsection
\def\subsection{\par
  \setlength{\leftmargin}{\parindentvalue}
  \leftskip\leftmargin
  \@totalleftmargin\leftmargin\linewidth\dimexpr\textwidth-\leftmargin\relax
  \xsubsection}
\let\xsubsubsection\subsubsection
\def\subsubsection{\par
  \setlength{\leftmargin}{2\parindentvalue}
  \leftskip\leftmargin
  \@totalleftmargin\leftmargin\linewidth\dimexpr\textwidth-\leftmargin\relax
  \xsubsubsection}
\makeatother



% table & table caption
\captionsetup[table]{format=hang,labelfont={bf}, textfont={bf},name={ตารางที่}, labelsep=space, singlelinecheck=off}
\renewcommand{\arraystretch}{1}

% figures
\captionsetup[figure]{format=hang,font={bf},name={รูปที่},justification=centering, labelsep=space, singlelinecheck=off}

% codeblock
\captionsetup[lstlisting]{format=hang,labelfont={bf}, textfont={bf}, labelsep=space, singlelinecheck=off}

% table & figure position
\makeatletter% because def contain @ 
    \def\fps@figure{H}
    \def\fps@table{H}
\makeatother


% ## List Style & Numbering
\makeatletter
\newcommand*{\compress}{\@minipagetrue}
\makeatother


\setlist[enumerate]{label = \arabic*),align=left, labelindent=\parindentvalue, leftmargin=*, widest=00),nosep}

\newlist{tabnum}{enumerate}{1}
\setlist[tabnum]{label = \arabic*),align=left, labelindent=\parindentvalue, widest=00),nosep, after=\vspace{-\baselineskip}, before=\compress}

% ## Code Block Style ##
\renewcommand{\lstlistingname}{โปรแกรมที่}
\lstset{
	basicstyle=\monofont \raggedright \fontsize{12pt}{1em}\selectfont,
	frame=single,
	aboveskip=20pt,
	belowskip=20pt,
	abovecaptionskip=0pt,
	breaklines=true,
	resetmargins=true,
}

% ## Bibliography Styles ##
\addto{\captionsthai}{\renewcommand{\bibname}{บรรณานุกรม}}

\renewcommand{\bibsection}{
	\begin{center}
		\fontsize{24pt}{1em}\selectfont
		\textbf{\bibname}
		\addcontentsline{toc}{chapter}{\bibname}
	\end{center}
	\vspace*{-\baselineskip + 40pt}
}

\renewcommand{\bibsep}{15pt}
\bibliographystyle{apa}

% ## Command to start appendix ##
\def\thaialph#1{\expandafter\thalph\csname c@#1\endcsname}
\def\thalph#1{%
    \ifcase#1\or ก\or ข\or ค\or ง\or จ\or ฉ\or ช\or ซ\or
    ฌ\or ญ\or ฎ\or ฏ\or ฐ\or ฑ\or ฒ\or ณ\or ด\or ต\or ถ\or ท\or ธ\or น\or
    บ\or ป\or ผ\or ฝ\or พ\or ฟ\or ภ\or ม\or ย\or ร\or ฤ\or ล\or ฦ\or ว\or
    ศ\or ษ\or ส\or ห\or ฬ\or อ\else ฮ\else\xpg@ill@value{#1}{thalph}\fi}

\newcommand{\StartAppendix}{
	\setcounter{chapter}{0}

	\renewcommand{\thechapter}{\thaialph{chapter}}

	\titlecontents{chapter}[0mm]
	{\stepcounter{tocitem}\tocheadcont{\thelinenumber}{\thetocitem}{สารบัญ}}
	{\bfseries ภาคผนวก \thecontentslabel \space}
	{\bfseries}{\DotFill\contentspage}

	\titleformat{\chapter}[display]
	{\bfseries\centering\fontsize{18pt}{1em}\selectfont}
	{ภาคผนวก \thechapter}{0pt}{\vspace{10pt}\fontsize{18pt}{1em}\selectfont}
	\titlespacing*{\chapter}{0pt}{0pt}{20pt}
}

% ## Make Pages ##
\newcommand{\MakeCoverPage}{
	\newgeometry{top=1in, bottom=1in, left=1.2in, right=1in}
    \begin{center}
    \textbf{
		\pagenumbering{gobble}
		\fontsize{22pt}{1.3em}\selectfont
		\vspace{30pt}\\
        \ThesisTitleTH\\
		\MakeUppercase{\ThesisTitleTwoLinesEN}\\
		\fontsize{18pt}{1em}\selectfont
		\vspace{162pt}
		\AuthorAFirstNameTH \space\space \AuthorALastNameTH\\
		\AuthorBFirstNameTH \space\space  \AuthorBLastNameTH
		\vspace{162pt}\\
		ปริญญานิพนธ์นี้เป็นส่วนหนึ่งของการศึกษาตามหลักสูตรปริญญาวิศวกรรมศาสตรบัณฑิต\\
		สาขาวิชาวิศวกรรมคอมพิวเตอร์ คณะวิศวกรรมศาสตร์\\
		สถาบันเทคโนโลยีพระจอมเกล้าเจ้าคุณทหารลาดกระบัง\\
		ปีการศึกษา \AcademicYear
    }
    \end{center} 
	\clearpage
	\restoregeometry
}


\newcommand{\MakeThesisCert}{
\begin{flushleft}
	ปริญญานิพนธ์ปีการศึกษา \AcademicYear\\
	สาขาวิชาวิศวกรรมคอมพิวเตอร์\\
	คณะวิศวกรรมศาสตร์ สถาบันเทคโนโลยีพระจอมเกล้าเจ้าคุณทหารลาดกระบัง\\
	เรื่อง\hspace{1cm}\ThesisTitleTH\\
	\phantom{เรื่อง}\hspace{1cm}\MakeUppercase{\ThesisTitleEN}
	\vspace{20pt}\\
	ผู้จัดทำ\\
	\begin{tabular}{ @{}lllll@{} }
	1. & \AuthorATitleTH\AuthorAFirstNameTH & \AuthorALastNameTH & รหัสนักศึกษา & \AuthorAStudentID \\
	2. & \AuthorBTitleTH\AuthorBFirstNameTH & \AuthorBLastNameTH & รหัสนักศึกษา & \AuthorBStudentID
	\end{tabular}
	\vspace{100pt}\\
	\begin{flushright}
	\begin{tabular}{ @{} p{6cm} l @{} }
		\DotFill & อาจารย์ที่ปรึกษา\\
		\centering (\AdvisorTitleTH\space\AdvisorFirstNameTH \space\space \AdvisorLastNameTH) & \null
	\end{tabular}	
	\end{flushright}
	\clearpage
\end{flushleft}
}


\newcommand{\MakeAbstractTH}[1]{
	\addcontentsline{toc}{preamble}{บทคัดย่อ}
	\noindent
	\begin{center}
		\fontsize{24pt}{1em}\selectfont
		\textbf{\ThesisTitleTwoLinesTH}
	\end{center}
	\begin{flushright}
		\begin{tabular}{ @{}lll@{} }
				\AuthorATitleTH\AuthorAFirstNameTH & \AuthorALastNameTH & \AuthorAStudentID\\
				\AuthorBTitleTH\AuthorBFirstNameTH & \AuthorBLastNameTH & \AuthorBStudentID\\
				\AdvisorTitleTH\AdvisorFirstNameTH & \AdvisorLastNameTH & อาจารย์ที่ปรึกษา\\
				ปีการศึกษา \AcademicYear & \null & \null
		\end{tabular}
	\end{flushright}
	\vspace{20pt}
	\textbf{\fontsize{18pt}{1em}\selectfont บทคัดย่อ}\\
	\indent
	\justifying
	#1
	\clearpage
}

\newcommand{\MakeAbstractEN}[1]{
	\addcontentsline{toc}{preamble}{บทคัดย่อ ภาษาอังกฤษ}
	\noindent
	\begin{center}
		\fontsize{24pt}{1em}\selectfont
		\textbf{\MakeUppercase{\ThesisTitleTwoLinesEN}}
	\end{center}
	\begin{flushright}
		\begin{tabular}{ @{}lll@{} }
				\AuthorATitleEN\AuthorAFirstNameEN & \AuthorALastNameEN & \AuthorAStudentID\\
				\AuthorBTitleEN\AuthorBFirstNameEN & \AuthorBLastNameEN & \AuthorBStudentID\\
				\AdvisorTitleEN\AdvisorFirstNameEN & \AdvisorLastNameEN & Advisor\\
				Academic Year \AcademicYear & \null & \null
		\end{tabular}
	\end{flushright}
	\vspace{20pt}
	\textbf{\fontsize{18pt}{1em}\selectfont ABSTRACT}\\
	\indent
	\justifying
	#1
	\clearpage
}

\newcommand{\MakeAcknowledgement}[1]{
	\noindent
	\begin{center}
		\textbf{
			\fontsize{24pt}{1em}\selectfont
			กิตติกรรมประกาศ
		}\\
		\vspace{30pt}
	\end{center}
	\indent
	#1
	\vspace{40pt}\\
	\begin{flushright}
	\begin{tabular}{ @{}ll@{} }
		\AuthorAFirstNameTH & \AuthorALastNameTH\\
		\AuthorBFirstNameTH & \AuthorBLastNameTH
	\end{tabular}
	\end{flushright}
	\clearpage
}