\NeedsTeXFormat{LaTeX2e}

\ProvidesClass{cekmitlprojectreport}

\LoadClass[a4paper, oneside]{book}
\RequirePackage[top=1in, bottom=1in, left=1.5in, right=1in,reversemarginpar=true]{geometry}
\RequirePackage{fontspec}
\RequirePackage[fontsize=16pt]{fontsize}
\RequirePackage{xunicode}
\RequirePackage{xltxtra}
\RequirePackage{textpos}
\RequirePackage{lmodern}
\RequirePackage{ragged2e}
\RequirePackage{babel}
\RequirePackage{titlesec}
\RequirePackage{indentfirst}
\RequirePackage{enumitem}
\RequirePackage{tabularx}
\RequirePackage{colortbl}
\RequirePackage{caption}
\RequirePackage{float}
\RequirePackage{calc}
\RequirePackage{graphicx}
\RequirePackage{fancyhdr}
\RequirePackage{titletoc}
\RequirePackage{ifthen}
\RequirePackage{lineno}
\RequirePackage{soul}
\RequirePackage{amsmath}
\RequirePackage{natbib}
\RequirePackage{etoolbox}
\RequirePackage[strict]{changepage}
\RequirePackage{listings}
\RequirePackage[hidelinks,hypertexnames=false]{hyperref}
\RequirePackage[normalem]{ulem}
\RequirePackage{readarray}
\RequirePackage{tikz}
\RequirePackage{url}
% \RequirePackage[nottoc,numbib]{tocbibind}
% \RequirePackage[none]{hyphenat}
\urlstyle{same}



\babelprovide[main, import, hyphenrules=nohyphenation]{thai}
\graphicspath{ {./images/} }

% ## Constants Setup ##
\newcommand{\thesistitle}[2]{
	\newcommand{\ThesisTitleTH}{#1}
	\newcommand{\ThesisTitleEN}{#2}
}
\newcommand{\academicyear}[2]{
	\newcommand{\AcademicYearTH}{#1}
	\newcommand{\AcademicYearEN}{#2}
}


\newcounter{authorcount}
\setcounter{authorcount}{0}
\newcounter{advisorcount}
\setcounter{advisorcount}{0}

\readarraysepchar{\\}
\newcommand{\authorlistraw}{}
\newcommand{\advisorlistraw}{}

% #1 = TitleTH
% #2 = FirstNameTH
% #3 = LastNameTH
% #4 = TitleEN
% #5 = FirstNameEN
% #6 = LastNameEN
% #7 = StudentID

\newcommand{\authordetail}[7]{
	\stepcounter{authorcount}
	\appto\authorlistraw{#1\\#2\\#3\\#4\\#5\\#6\\#7\\}
	\readarray\authorlistraw\AuthorList[-,7]
}

\newcommand{\advisordetail}[6]{
	\stepcounter{advisorcount}
	\appto\advisorlistraw{#1\\#2\\#3\\#4\\#5\\#6\\}
	\readarray\advisorlistraw\AdvisorList[-,6]
}


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
	\renewcommand{\thepage}{\texorpdfstring{\MakeUppercase{\roman{page}}}{\roman{page}}}
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
    \ifthenelse{#1>27 \OR #2>27}{
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
    \ifthenelse{#1>27 \OR #2>27}{
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
\renewcommand{\arraystretch}{1.5}

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
\SetEnumitemKey{table}{
	leftmargin=*,
	labelindent=0pt,
	before=\vspace{-\baselineskip + \arraystretch\tabcolsep},
	after=\vspace{-\baselineskip + \arraystretch\tabcolsep},
}
\setlist[itemize]{nosep,align=left, labelindent=\parindentvalue, leftmargin=*}

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
\bibliographystyle{plainnat}

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
	{ภาคผนวก \thecontentslabel \space}
	{}{\DotFill\contentspage}

	\titleformat{\chapter}[display]
	{\bfseries\centering\fontsize{20pt}{1em}\selectfont}
	{ภาคผนวก \thechapter}{0pt}{\vspace{10pt}\fontsize{24pt}{1em}\selectfont}
	\titlespacing*{\chapter}{0pt}{0pt}{20pt}
}

% ## Make Pages ##
\newcommand{\tabularcontent}{}
\newcommand{\authorlistfortabular}{}

\newcommand{\MakeCoverPage}{
	\newgeometry{top=1in, bottom=1in, left=1.2in, right=1in}
    \begin{center}
    \textbf{
		\pagenumbering{gobble}
		\fontsize{22pt}{1.3em}\selectfont
        \ThesisTitleTH\\
		\MakeUppercase{\ThesisTitleEN}\\
		\fontsize{18pt}{1em}\selectfont
		\vspace{\fill}
		\foreach \i in {1,...,\theauthorcount}
			{
				\AuthorList[\i,2] \space\space \AuthorList[\i,3]\\
			}
		\vspace{\fill}
		ปริญญานิพนธ์นี้เป็นส่วนหนึ่งของการศึกษาตามหลักสูตรปริญญาวิศวกรรมศาสตรบัณฑิต\\
		สาขาวิชาวิศวกรรมคอมพิวเตอร์ คณะวิศวกรรมศาสตร์\\
		สถาบันเทคโนโลยีพระจอมเกล้าเจ้าคุณทหารลาดกระบัง\\
		ปีการศึกษา \AcademicYearTH
    }
    \end{center}
	\clearpage
	\restoregeometry
}


\newcommand{\MakeThesisCert}{
\begin{flushleft}
	\renewcommand{\arraystretch}{1.0}
	ปริญญานิพนธ์ปีการศึกษา \AcademicYearTH\\
	สาขาวิชาวิศวกรรมคอมพิวเตอร์\\
	คณะวิศวกรรมศาสตร์ สถาบันเทคโนโลยีพระจอมเกล้าเจ้าคุณทหารลาดกระบัง\\
	เรื่อง\hspace{1cm}\ThesisTitleTH\\
	\phantom{เรื่อง}\hspace{1cm}\MakeUppercase{\ThesisTitleEN}
	\vspace{20pt}\\
	ผู้จัดทำ\\
	{
		\renewcommand{\authorlistfortabular}{}
		\foreach \i in {1,...,\theauthorcount}
			{
				\xappto\authorlistfortabular{\i. & \AuthorList[\i,1]\AuthorList[\i,2] & \AuthorList[\i,3] & รหัสนักศึกษา & \AuthorList[\i,7]}
				\gappto\authorlistfortabular{\\}
			}
		\begin{tabular}{ @{}lllll@{} }
			\authorlistfortabular
		\end{tabular}
	}
	\vspace{100pt}
	\begin{flushright}
		\begin{tabular}{ @{} p{7cm} l @{} }
			\DotFill & อาจารย์ที่ปรึกษา\ifnumgreater{\theadvisorcount}{1}{\phantom{ร่วม}}{}\\
			\centering (\AdvisorList[1,1]\AdvisorList[1,2]\space\space\AdvisorList[1,3]) & \null
		\end{tabular}
	\end{flushright}
	\ifnumgreater{\theadvisorcount}{1}
	{
		\foreach \i in {2,...,\theadvisorcount}
			{
				\vspace{60pt}
				\renewcommand{\tabularcontent}{}
				\xappto\tabularcontent{\centering (\AdvisorList[\i,1]\AdvisorList[\i,2]\space\space\AdvisorList[\i,3]) & \null}
				\begin{flushright}
					\begin{tabular}{ @{} p{7cm} l @{} }
						\DotFill & อาจารย์ที่ปรึกษาร่วม\\
						\tabularcontent
					\end{tabular}
				\end{flushright}
			}
	}{}
	\clearpage
\end{flushleft}
}


\newcommand{\MakeAbstractTH}[1]{
	\addcontentsline{toc}{preamble}{บทคัดย่อ}
	\noindent
	\begin{center}
		\fontsize{24pt}{1em}\selectfont
		\textbf{\ThesisTitleTH}
	\end{center}
	\begin{flushright}
		\renewcommand{\arraystretch}{1.0}
		{
			\renewcommand{\tabularcontent}{}
			\foreach \i in {1,...,\theauthorcount}
				{
					\xappto\tabularcontent{\AuthorList[\i,1]\AuthorList[\i,2] & \AuthorList[\i,3] & \AuthorList[\i,7]}
					\gappto\tabularcontent{\\}
				}
			\xappto\tabularcontent{\AdvisorList[1,1]\AdvisorList[1,2] & \AdvisorList[1,3] & อาจารย์ที่ปรึกษา}
			\ifnumgreater{\theadvisorcount}{1}
			{
				\foreach \i in {2,...,\theadvisorcount}
				{
					\gappto\tabularcontent{\\}
					\xappto\tabularcontent{\AdvisorList[\i,1]\AdvisorList[\i,2] & \AdvisorList[\i,3] & อาจารย์ที่ปรึกษาร่วม}
				}
			}{}
			\begin{tabular}{ @{}lllll@{} }
				\tabularcontent \\
				ปีการศึกษา \AcademicYearTH & \null & \null
			\end{tabular}
		}
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
		\textbf{\MakeUppercase{\ThesisTitleEN}}
	\end{center}
	\begin{flushright}
		\renewcommand{\arraystretch}{1.0}
		{
			\renewcommand{\tabularcontent}{}
			\foreach \i in {1,...,\theauthorcount}
				{
					\xappto\tabularcontent{\AuthorList[\i,4]\AuthorList[\i,5] & \AuthorList[\i,6] & \AuthorList[\i,7]}
					\gappto\tabularcontent{\\}
				}
			\xappto\tabularcontent{\AdvisorList[1,4]\AdvisorList[1,5] & \AdvisorList[1,6] & Advisor}
			\ifnumgreater{\theadvisorcount}{1}
			{
				\foreach \i in {2,...,\theadvisorcount}
				{
					\gappto\tabularcontent{\\}
					\xappto\tabularcontent{\AdvisorList[\i,4]\AdvisorList[\i,5] & \AdvisorList[\i,6] & Co-Advisor}
				}
			}{}

			\begin{tabular}{ @{}lllll@{} }
				\tabularcontent \\
				Academic Year {\AcademicYearEN} & \null & \null
			\end{tabular}
		}
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
		\renewcommand{\arraystretch}{1.0}
		\renewcommand{\authorlistfortabular}{}
		\foreach \i in {1,...,\theauthorcount}
			{
					\xappto\authorlistfortabular{\AuthorList[\i,2] & \AuthorList[\i,3]}
					\gappto\authorlistfortabular{\\}
			}
		\begin{tabular}{ @{}ll@{} }
			\authorlistfortabular
		\end{tabular}
	\end{flushright}
	\clearpage
}