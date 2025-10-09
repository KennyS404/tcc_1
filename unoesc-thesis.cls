%%
%% Copyright © 2023–2024 The UnoescTeX Project team and any individual authors
%% listed elsewhere in this file.
%%
%% This work may be distributed and/or modified under the conditions of the
%% LaTeX Project Public License, either version 1.3 of this license or (at your
%% option) any later version.
%%
%% The latest version of this license is in:
%%
%%   https://www.latex-project.org/lppl.txt
%%
%% and version 1.3c or later is part of all distributions of LaTeX version 2008
%% or later.
%%
%% This work has the LPPL maintenance status `maintained'.
%%
%% The Current Maintainer of this work is Marlon Luís de Col.
%%
%% This work consists of the file `unoesc-thesis.cls'.
%%
\NeedsTeXFormat{LaTeX2e}
\NewExpandableDocumentCommand\ut@classname{}{unoesc-thesis}
\ProvidesClass\ut@classname[%
  2023-03-25
  0.0.0
  Classe para elaboração e formatação de trabalhos acadêmicos da Unoesc Chapecó]

% Nome estilizado desta classe
\NewExpandableDocumentCommand\UnoescTeX{}{Unoesc\TeX}

% Comandos de feedback ao usuário
\NewDocumentCommand\ut@error{m m}{\ClassError\ut@classname{#1}{#2.}}
\NewDocumentCommand\ut@warning{m}{\ClassWarningNoLine\ut@classname{#1}}

% Cria e recria comandos dinamicamente
\NewDocumentCommand\ut@namedef{m}{\expandafter\NewDocumentCommand\csname#1\endcsname}
\NewDocumentCommand\ut@renewnamedef{m}{\expandafter\RenewDocumentCommand\csname#1\endcsname}
\NewDocumentCommand\ut@providenamedef{m}{\expandafter\ProvideDocumentCommand\csname#1\endcsname}
\NewDocumentCommand\ut@declarenamedef{m}{\expandafter\DeclareDocumentCommand\csname#1\endcsname}

% Cria e recria comandos expansíveis dinamicamente
\NewDocumentCommand\ut@nameedef{m}{\expandafter\NewExpandableDocumentCommand\csname#1\endcsname}
\NewDocumentCommand\ut@renewnameedef{m}{\expandafter\RenewExpandableDocumentCommand\csname#1\endcsname}
\NewDocumentCommand\ut@providenameedef{m}{\expandafter\ProvideExpandableDocumentCommand\csname#1\endcsname}
\NewDocumentCommand\ut@declarenameedef{m}{\expandafter\DeclareExpandableDocumentCommand\csname#1\endcsname}

% Renomeia um comando
\NewDocumentCommand\ut@renamedef{m m}{\NewCommandCopy#2#1\ut@undef#1}

% Remove um comando
\NewDocumentCommand\ut@undef{m}{\RenewCommandCopy#1\@undefined}
\NewDocumentCommand\ut@nameundef{m}{\expandafter\ut@undef\csname#1\endcsname}

% Cria comandos de definições condicionais
\NewDocumentCommand\ut@true{m}{\@nameuse{ut@#1true}}
\NewDocumentCommand\ut@false{m}{\@nameuse{ut@#1false}}

% Cria comandos condicionais
\NewDocumentCommand\ut@newif{m}{\expandafter\newif\csname ifut@#1\endcsname}
\NewDocumentCommand\ut@newiftrue{m}{\ut@newif{#1}\ut@true{#1}}

% Retorna a definição do primeiro comando, caso exista, senão o segundo
% argumento
\NewDocumentCommand\ut@coalesce{m m}{\@ifundefined{#1}{#2}{\@nameuse{#1}}}

% Define novas medidas
\NewDocumentCommand\ut@newdimen{m O{}}{%
  \expandafter\newdimen\csname ut@#1\endcsname
  \IfBlankF{#2}{\@nameuse{ut@#1}#2}}
\NewDocumentCommand\ut@newskip{m O{}}{%
  \expandafter\newskip\csname ut@#1\endcsname
  \IfBlankF{#2}{\@nameuse{ut@#1}#2}}

% Impressão em ambos os lados
\DeclareOption{twoside}{\@twosidetrue}

% Fonte sans-serif
\ut@newif{sans}
\DeclareOption{sans}{\ut@sanstrue}

% Ligaduras nas fontes
\ut@newif{ligatures}
\DeclareOption{ligatures}{%
  \ifut@sans
    \ut@error{A fonte sans-serif não oferece suporte a ligaduras}{%
      Remova a opção de ligaduras ou, se quiser utilizá-las, a opção de fonte sans-serif}
  \else
    \ut@ligaturestrue
  \fi}

% Lista os símbolos por ordem de aparição
\ut@newif{symbolsbyappearance}
\DeclareOption{symbolsbyappearance}{\ut@symbolsbyappearancetrue}

% Processa as opções da classe
\ProcessOptions\relax

% Permite colorir o texto
\RequirePackage{xcolor}
\selectcolormodel{cmyk}
\definecolorset{rgb/cmyk}{unoesc-}{}{%
  green,96,198,89/0.58,0,0.7,0;%
  blue,58,117,196/0.9,0.56,0,0}

% Define a cor padrão da fonte
\color{black}

% Configura as dimensões da fonte
\ut@newdimen{lineheight}
\ut@newdimen{linesize}
\ut@newdimen{linedepth}
\NewDocumentCommand\ut@fontsize{m}{%
  \ut@lineheight#1\relax
  \ut@linesize1.2\ut@lineheight
  \ut@linedepth\dimeval{\ut@linesize-\ut@lineheight}
  \fontsize\ut@lineheight\ut@linesize\selectfont}

% Predefine os tamanhos da fonte
\ut@newdimen{normalsize}[12\p@]
\RenewDocumentCommand\normalsize{}{\ut@fontsize\ut@normalsize}
\NewDocumentCommand\footnotesize{}{\ut@fontsize{10\p@}}
\NewDocumentCommand\scriptsize{}{\ut@fontsize{8\p@}}

% Providencia suporte a fontes OpenType e a ambientes matemáticos
% \RequirePackage{unicode-math}  % Comentado: não compatível com pdfLaTeX

% Seleção da fonte
\usepackage[T1]{fontenc}
\usepackage[utf8]{inputenc}
\usepackage{lmodern}  % Ou outra fonte compatível com pdfLaTeX
\ifut@sans
  \RenewDocumentCommand\familydefault{}{\sfdefault}
  % \setmainfont{Times New Roman}  % Comentado: não compatível com pdfLaTeX
  % \setmathfont{Fira Math}  % Comentado: não compatível com pdfLaTeX
\else
\fi

% Tamanho do papel
\paperwidth21cm
\paperheight29.7cm

% Normaliza a diagramação da página
\hoffset-1in
\voffset-1in

% Definição das margens
\ut@newdimen{topmargin}[3cm]
\ut@newdimen{outermargin}[2cm]
\ut@newdimen{bottommargin}[2cm]
\ut@newdimen{innermargin}[3cm]

% Diagramação da área textual
\textwidth\dimeval{\paperwidth-\ut@innermargin-\ut@outermargin}
\textheight\dimeval{\paperheight-\ut@topmargin-\ut@bottommargin}

% Margem superior e dimensões do cabeçalho
\topmargin\ut@outermargin
\headheight\ht\strutbox
\headsep\dimeval{\ut@topmargin-\topmargin-\headheight}

% Margens laterais
\oddsidemargin\ut@innermargin
\evensidemargin\ut@outermargin

% Numeração de página
\pagenumbering{arabic}
\RenewDocumentCommand\ps@plain{}{%
  % Páginas ímpares
  \RenewCommandCopy\@oddfoot\@empty
  \RenewDocumentCommand\@oddhead{}{\hfill\thepage}

  % Páginas pares
  \RenewCommandCopy\@evenfoot\@empty
  \RenewDocumentCommand\@evenhead{}{\thepage\hfill}}

% Espaçamentos entre-linhas
\ut@newskip{interlineskip}
\NewDocumentCommand\ut@baselinestretch{m}{%
  \RenewExpandableDocumentCommand\baselinestretch{}{#1}\selectfont
  \ut@interlineskip\dimeval{\baselineskip-\ut@linesize}}
\NewDocumentCommand\ut@singlespacing{}{\ut@baselinestretch{1}}
\NewDocumentCommand\ut@onehalfspacing{}{\ut@baselinestretch{1.5}}

% Adiciona uma ou mais linhas em branco
\NewDocumentCommand\ut@blankline{O{\@ne}}{\vspace{#1\baselineskip}}
\NewDocumentCommand\ut@blankskip{O{\@ne}}{\vspace{\dimeval{#1\baselineskip+#1\ut@lineheight}}}

% Define espaçamento entre-linhas de 1,5
\ut@onehalfspacing

% Espaçamentos de parágrafo
\raggedbottom
\parskip\z@
\parindent\z@
\frenchspacing

% Recuo de primeira linha
\ut@newdimen{parindent}[1.25cm]

% Implementam comandos para manipulação de strings
\RequirePackage{mfirstuc,xstring}

% Habilita hifenização de palavras em português do Brasil
\RequirePackage[brazilian]{babel}
\babelprovide[transforms=hyphen.repeat]{brazilian}

% Referências bibliográficas
\AtEndPreamble{\RequirePackage{csquotes}}
\RequirePackage[style=abnt]{biblatex}
\DeclareLanguageMapping{brazil}{brazilian}

% Prefixa a extensão do arquivo de uma lista de recursos
\NewDocumentCommand\ut@tocextension{m}{#1.toc}

% Extensão do arquivo do sumário
\NewDocumentCommand\ext@ut@sumario{}{\ut@tocextension{sumario}}

% Referenciação de elementos no texto
\RequirePackage[%
  bookmarksdepth=5,
  bookmarkstype=\ext@ut@sumario,
  breaklinks,
  hidelinks,
  linktoc=none,
  pdfcreator=UnoescTeX,
  pdfdisplaydoctitle,
  pdfduplex=\if@twoside DuplexFlipLongEdge\else Simplex\fi,
  pdflang=pt-BR,
  pdfpagelabels,
  pdfpagelayout=\if@twoside TwoColumnRight\else OneColumn\fi,
  pdfproducer={UnoescTeX (\ut@classname)},
  pdfversion=1.7,
]{hyperref}

% Configura quebra de seção
\if@twoside
  \NewDocumentCommand\ut@firstpage{}{-1}
\else
  \NewDocumentCommand\ut@firstpage{}{0}
\fi
\setcounter{page}{\ut@firstpage}
\RenewDocumentCommand\cleardoublepage{}{%
  \ifnum\c@page=\ut@firstpage
    \thispdfpagelabel{Capa}
  \fi
  \clearpage
  \if@twoside
    \ifodd
      \c@page
    \else
      \null\thispagestyle{empty}
      \ifnum\c@page=\z@
        \thispdfpagelabel{2ª capa}
      \fi
      \clearpage
    \fi
  \fi}

% Inclui arquivo de código-fonte em uma nova página
\NewDocumentCommand\append{}{\cleardoublepage\input}

% Nome da instituição
\NewExpandableDocumentCommand\Unoesc{}{Universidade do Oeste de Santa Catarina}

% Título do trabalho
\NewDocumentCommand\titulo{>{\TrimSpaces} m >{\TrimSpaces} O{}}{%
  \RenewExpandableDocumentCommand\titulo{}{#1}
  \NewExpandableDocumentCommand\subtitulo{}{#2}
  \NewExpandableDocumentCommand\titulocompleto{}{\titulo\IfBlankF{#2}{: \subtitulo}}
  \hypersetup{pdftitle=\titulocompleto}
  \NewExpandableDocumentCommand\ut@title{}{\MakeUppercase{#1}\IfBlankF{#2}{: \subtitulo}}}
\AtBeginDocument{%
  \ifx\ut@title\@undefined
    \titulo{Sem título}
    \RenewExpandableDocumentCommand\ut@title{}{\textcolor{red}{\MakeUppercase{\titulo}}}
  \fi}

% Predefine opções de autoria do trabalho
\ut@newiftrue{noautor}
\NewDocumentCommand\ut@author{O{o} m m}{%
  \ut@namedef{#2}{>{\TrimSpaces} m}{%
    \ut@false{noautor}
    \ut@renewnameedef{#2}{}{##1}
    \hypersetup{pdfauthor={##1}}
    \RenewExpandableDocumentCommand\ut@author{}{\MakeUppercase{##1}}
    \NewExpandableDocumentCommand\ut@citemename{}{#1 #2}
    \ut@nameundef{#3}}}
\AtBeginDocument{%
  \ifut@noautor
    \autor{Autor desconhecido}
    \RenewExpandableDocumentCommand\ut@author{}{\textcolor{red}{\MakeUppercase{\autor}}}
  \fi}

% Define opções de autoria do trabalho
\ut@author{autor}{autora}
\ut@author[a]{autora}{autor}

% Predefine opções de metadado
\NewDocumentCommand\ut@metadata{O{o} m m O{}}{%
  \ut@newiftrue{no#2}
  \ut@namedef{#2}{>{\TrimSpaces} m}{%
    \ut@false{no#2}
    \ut@renewnameedef{#2}{}{##1}
    \IfBlankF{#4}{\hypersetup{#4={##1}}}}
  \AtBeginDocument{%
    \expandafter\ifx\csname ifut@no#2\expandafter\endcsname\csname iftrue\endcsname
      \ut@error{\MFUsentencecase#1 #3 não foi definid#1}{%
        Utilize o comando \expandafter\protect\csname#2\endcsname\space para definir #1 #3}
    \fi}}

% Define opções de metadados
\ut@metadata[a]{cidade}{cidade do campus}
\ut@metadata[a]{data}{data da produção do trabalho}

% Capa do trabalho
\AtBeginDocument{%
  \ut@pdfpagebookmark{Capa}
  \begingroup
    \centering\bfseries
    \MakeUppercase{\Unoesc}\par\nobreak
    \vspace{\stretch{10}}
    \ut@author\par\nobreak
    \vspace{\stretch{11}}
    \ut@title\par\nobreak
    \vspace{\stretch{22}}
    \MakeUppercase{\cidade}, SC\par\nobreak
    \data\par
  \endgroup}

% Descrição do trabalho
\ut@metadata[a]{descricao}{descrição do trabalho}[pdfsubject]

% Extensão do arquivo de coautores
\NewDocumentCommand\ext@ut@coautor{}{\ut@tocextension{coautor}}

% Formata a exibição de um coautor
\NewDocumentCommand\coauthorline{m m}{\MFUsentencecase#1: #2\par\nobreak}

% Predefine coautor
\ut@newiftrue{nocoauthor}
\NewDocumentCommand\coautor{m >{\TrimSpaces} m}{%
  \ut@nameedef{#1}{}{#2}
  \ifut@nocoauthor\ut@nocoauthorfalse\fi
  \addtocontents\ext@ut@coautor{%
    \protect\coauthorline{#1}{#2}\protected@file@percent}}
\AtBeginDocument{%
  \ifut@nocoauthor
    \ut@error{Nenhum coautor foi definido}{%
      Utilize o comando \protect\coautor\space para definir ao menos um coautor, como o orientador do autor ou autora ou o professor da disciplina}
  \fi}

% Folha de rosto do trabalho
\AtBeginDocument{%
  \cleardoublepage
  \pagenumbering{Roman}
  \ut@pdfpagebookmark{Folha de rosto}
  \begingroup
    \centering
    \ut@author\par\nobreak
    \vspace{\stretch{15}}
    \ut@title\par\nobreak
  \endgroup
  \vspace{\stretch{5}}
  \begingroup
    \leftskip6cm
    \ut@singlespacing\sloppy\descricao.\par\nobreak
  \endgroup
  \vspace{\stretch{2}}
  \begingroup
    \raggedright
    \ut@toc{coautor}\par\nobreak
    \vspace{\stretch{16}}
    \centering
    \cidade, SC\par\nobreak
    \data\par
  \endgroup}

% Implementa estrutura de pilha simples
\NewDocumentCommand\newstack{>{\TrimSpaces} m}{%
  \newcounter{#1@size}
  \ut@namedef{#1size}{}{\value{#1@size}}
  \ut@namedef{#1set}{m >{\TrimSpaces} m}{%
    \ifnum\z@<##1\ifnum##1<\inteval{\value{#1@size}+\tw@}%
      \expandafter\gdef\csname#1\romannumeral##1\endcsname{##2}%
    \fi\fi}
  \ut@namedef{#1get}{m m}{%
    \ifcsname#1\romannumeral##1\endcsname
      \edef##2{\@nameuse{#1\romannumeral##1}}%
    \fi}
  \ut@namedef{#1push}{}{%
    \stepcounter{#1@size}%
    \@nameuse{#1set}{\value{#1@size}}}%
  \ut@namedef{#1pop}{m}{%
    \@nameuse{#1get}{\value{#1@size}}{##1}%
    \addtocounter{#1@size}{-1}}
  \ut@namedef{#1print}{m O{, } O{\@iden}}{%
    \edef##1{}%
    \newcount\@i
    \loop\ifnum\@i<\value{#1@size}%
      \advance\@i\@ne\relax
      \ifcsname#1\romannumeral\@i\endcsname
        \edef##1{##1\expandafter##3{\csname#1\romannumeral\@i\endcsname}}%
        \ifnum\@i<\value{#1@size}%
          \edef##1{##1##2}%
        \fi
      \fi
    \repeat}
  \ut@namedef{#1enumerate}{m O{e} O{\@iden}}{%
    \edef##1{}%
    \newcount\@i
    \loop\ifnum\@i<\value{#1@size}%
      \advance\@i\@ne\relax
      \ifcsname#1\romannumeral\@i\endcsname
        \edef##1{##1\expandafter##3{\csname#1\romannumeral\@i\endcsname}}%
        \ifnum\inteval{\value{#1@size}-\@i}>\@ne
          \edef##1{##1, }%
        \else\ifnum\inteval{\value{#1@size}-\@i}>\z@
          \edef##1{##1 ##2 }%
        \fi\fi
      \fi
    \repeat}
  \ut@namedef{#1reset}{}{\setcounter{#1@size}{\z@}}}

% Palavras-chave
\newstack{ut@keywords}
\newstack{ut@pdfkeywords}
\NewDocumentCommand\palavraschave{O{\@iden} >{\SplitList{,}} m}{%
  \begingroup
    \NewDocumentCommand\ut@keywordpush{m}{%
      \ut@keywordspush{{#1{##1}}}}
    \ProcessList{#2}{\ut@keywordpush}
    \NewDocumentCommand\ut@pdfkeywordpush{m}{%
      \IfSubStr{##1}{ }{%
        \ut@pdfkeywordspush{'##1'}}
      {%
        \ut@pdfkeywordspush{##1}}}
    \ProcessList{#2}{\ut@pdfkeywordpush}
    \ut@pdfkeywordsprint\ut@pdfkeywords[ ]
    \hypersetup{pdfkeywords=\ut@pdfkeywords}
  \endgroup}
\AtBeginDocument{%
  \ifnum\ut@keywordssize=\z@
    \ut@error{Nenhuma palavra-chave foi definida}{%
      Utilize o comando \protect\palavraschave\space para definir uma ou mais palavras-chave}
  \fi
  \ifnum\ut@keywordssize=\@ne
    \NewExpandableDocumentCommand\ut@message{}{Apenas uma palavra-chave foi definida}
  \else\ifnum\ut@keywordssize=\tw@
    \NewExpandableDocumentCommand\ut@message{}{Apenas duas palavras-chave foram definidas}
  \fi\fi
  \ifx\ut@message\@undefined
    \ut@keywordsprint\palavraschave[; ]
  \else
    \ut@error{\ut@message}{Defina no mínimo três palavras-chave}
  \fi}

% Âncoras para navegação no arquivo PDF
\NewDocumentCommand\ut@pdftarget{m}{\raisebox\ut@lineheight{\hyper@anchor{#1}}}

% Bookmarks do arquivo PDF
\NewDocumentCommand\ut@pdfbookmark{m m m}{\Hy@writebookmark{}{#3}{#1}{#2}{\ext@ut@sumario}}

% Bookmarks de páginas do arquivo PDF
\NewDocumentCommand\ut@pdfpagebookmark{}{\ut@pdfbookmark{page.\thepage}{1}}

% Tipos de numeração de seção
\NewExpandableDocumentCommand\ut@numberedtitle{m}{\@nameuse{the#1}}
\NewExpandableDocumentCommand\ut@labeledtitle{m}{\MFUsentencecase{\@nameuse{#1name}}\nobreakspace\@nameuse{the#1}\nobreakspace\textendash}

% Predefine seção
\NewDocumentCommand\ut@section{O{} m O{\ut@numberedtitle} m m}{%
  \ifnum\@nameuse{toclevel@#2}>\@ne
    \par\addpenalty\@secpenalty
    \ut@blankline
  \else
    \cleardoublepage
  \fi
  \IfBlankT{#1}{\refstepcounter{#2}}
  \begingroup
    \IfBlankTF{#1}{%
      \NewExpandableDocumentCommand\ut@seccnt{}{#3{#2}\nobreakspace}
      \NewDocumentCommand\ut@seccntnumber{}{#4{\ut@seccnt}}
      \ut@newdimen{seccntwidth}
      \settowidth\ut@seccntwidth\ut@seccntnumber
      \leftskip\ut@seccntwidth
      \parindent-\leftskip}
    {%
      \MakeLinkTarget*{#1}}
    #4{%
      \leavevmode
      \ut@singlespacing
      \interlinepenalty\@M
      \IfBlankT{#1}{\hb@xt@\ut@seccntwidth{\ut@seccntnumber}}\sloppy#5}\par\nobreak
    \ifnum\@nameuse{toclevel@#2}>\z@
      \ut@blankline
      \addcontentsline\ext@ut@sumario{#2}{\IfBlankTF{#1}{\texorpdfstring{\ut@seccnt#5}{#5}}{#5}}
    \else
      \ut@blankline[\tw@]
      \IfBlankF{#1}{\ut@pdfbookmark{#1}{\@nameuse{bookmarklevel@#2}}{#5}}
    \fi
    \@afterheading
  \endgroup}

% Define capítulo pré-textual
\NewDocumentCommand\toclevel@ut@frontchapter{}{0}
\NewDocumentCommand\bookmarklevel@ut@frontchapter{}{2}
\NewDocumentCommand\ut@frontchapter{m}{\ut@section[pre:#1]{ut@frontchapter}{\centering\ut@capitulostyle}}

% Inibe a impressão de uma mensagem de log no stream 16 causada por um pacote
% de terceiro.
\NewDocumentCommand\writestatus{m m}{}

% Exibe uma lista de recursos
\NewDocumentCommand\ut@toc{m}{\@starttoc{\@nameuse{ext@ut@#1}}}

% Formata a exibição de uma lista de recursos
\NewDocumentCommand\ut@tocsection{m m}{%
  \ut@newif{shouldlist}
  \ifcsname c@ut@#1\endcsname
    \expandafter\ifx\csname ifut@#1\expandafter\endcsname\csname iftrue\endcsname
      \ut@shouldlisttrue
    \fi
  \else
    \ut@shouldlisttrue
  \fi
  \ifut@shouldlist
    \ifut@resourceslist
      \global\ut@false{resourceslist}
      \cleardoublepage
      \ut@pdfpagebookmark{Listas de recursos}
    \fi
    \ut@frontchapter{#1}{#2}
    \ut@toc{#1}
    \cleardoublepage
  \fi}

% Verifica a exibição de ao menos uma lista de recursos
\ut@newiftrue{resourceslist}

% Linha pontilhada
\NewDocumentCommand\ut@dotfill{}{%
  \leavevmode
  \cleaders\hbox{.}\hskip1em\@plus1fill
  \kern\z@}

% Entrada do sumário
\NewDocumentCommand\ut@dottedtocline{O{} m m}{%
  \par
  \begingroup
    \ut@singlespacing
    \Hy@toclinkstart#1{#2\ut@dotfill#3}\Hy@toclinkend
  \endgroup}

% Parametriza tipo de float
\newcounter{ut@floattype}
\stepcounter{ut@floattype}
\NewDocumentCommand\ut@float{m O{}}{%
  \define@key{ut@#1}{singular}{%
    \ut@declarenameedef{ut@#1singular}{}{##1}}
  \define@key{ut@#1}{plural}{%
    \ut@declarenameedef{ut@#1plural}{}{##1}}
  \setkeys{ut@#1}{%
    singular=#1,
    plural={\@nameuse{ut@#1singular}s}, #2}
  \newcounter{ut@#1}
  \ut@renewnameedef{theut@#1}{}{\arabic{ut@#1}}
  \ut@nameedef{ut@#1name}{}{\MFUsentencecase{\@nameuse{ut@#1singular}}}
  \ut@nameedef{ut@#1pluralname}{}{\MFUsentencecase{\@nameuse{ut@#1plural}}}
  \ut@nameedef{fps@ut@#1}{}{htp}
  \ut@namedef{l@ut@#1}{}{\ut@dottedtocline}
  \ut@namedef{ext@ut@#1}{}{\ut@tocextension{#1}}
  \ut@nameedef{ftype@ut@#1}{}{\c@ut@floattype}
  \addtocounter{ut@floattype}{\c@ut@floattype}
  \NewDocumentEnvironment{#1}{>{\TrimSpaces} m >{\TrimSpaces} m}{%
    \ifx\@captype\@undefined\else
      \begingroup
        \IfStrEq\@captype{ut@#1}{%
          \NewExpandableDocumentCommand\ut@context{}{outro}}
        {%
          \NewExpandableDocumentCommand\ut@context{}{um}}
        \ut@error{Ambiente de #2 declarado dentro de \ut@context\space ambiente de \@nameuse{\@captype name}}{%
          Ambientes de float, como de ilustração, quadro ou tabela, não podem ser aninhados}
      \endgroup
    \fi
    \@float{ut@#1}
      \ut@caption{##1}
      \ifut@withinfloatset\else
        \vspace{\dimeval{\ut@floattextskip-\prevdepth}}
      \fi}
  {%
      \ifut@withinfloatset\else
        \ut@source{##2}
      \fi
    \end@float}
  \newcounter{ut@#1element}[ut@#1]
  \ut@renewnameedef{theut@#1element}{}{\@nameuse{theut@#1}\alph{ut@#1element}}
  \ut@nameedef{ut@#1elementname}{}{\@nameuse{ut@#1name}}
  \ut@nameedef{ut@#1elementpluralname}{}{\@nameuse{ut@#1pluralname}}}

% Exibe uma lista de floats
\NewCommandCopy\floatslist\ut@tocsection

% Predefine tipo de float
\NewDocumentCommand\ut@floattype{m O{}}{%
  \newcounter{ut@#1@total}
  \ut@float{#1}[#2]
  \ut@newif{#1}
  \AtEndDocument{%
    \if@filesw
      \immediate\write\@mainaux{%
        \global\expandafter\noexpand\csname ut@#1\ifnum\value{ut@#1}>0
          true
        \else
          false
        \fi\endcsname}
    \fi}
  \ut@namedef{ext@ut@float@#1}{}{\ut@tocextension{#1.lst}}
  \addtocontents{\@nameuse{ext@ut@float@#1}}{%
    \protect\floatslist{#1}{Lista de \@nameuse{ut@#1plural}}\protected@file@percent}
  \ut@namedef{tipode#1}{m O{}}{%
    \define@key{ut@##1}{limiar}{%
      \ut@declarenamedef{ut@##1threshold}{}{####1}}
    \ut@nameedef{ut@##1parent}{}{ut@#1}
    \ut@float{##1}[limiar=10, ##2]
    \ut@newiftrue{##1}
    \AtEndDocument{%
      \if@filesw
        \immediate\write\@mainaux{%
          \global\expandafter\noexpand\csname ut@##1\ifnum\value{ut@##1}<\@nameuse{ut@##1threshold}
            false
          \else\ifnum\inteval{\value{ut@#1@total}-\value{ut@##1}}<5
            false
          \else
            true
          \fi\fi\endcsname}
      \fi}
    \addtocontents{\@nameuse{ext@ut@float@#1}}{%
      \protect\floatslist{##1}{Lista de \@nameuse{ut@##1plural}}\protected@file@percent}}
  \AtBeginDocument{\ut@toc{float@#1}}}

% Define os tipos de float
\ut@floattype{ilustracao}[%
  singular=ilustração,
  plural=ilustrações]
\ut@floattype{quadro}
\ut@floattype{tabela}

% Exibe uma lista de termos
\NewCommandCopy\termslist\ut@tocsection

% Formata a exibição de um termo
\NewDocumentCommand\termline{m m m m m}{%
  \begingroup
    \leftskip\@nameuse{#1@width}
    \parindent-\leftskip
    \interlinepenalty\@M
    \leavevmode
    \hb@xt@\leftskip{#3\hfill\nobreakspace}\textendash\nobreakspace\ut@pdftarget{#5}\sloppy#4\par
  \endgroup}

% Largura inicial mínima da coluna esquerda da listagem de termos
\ut@newdimen{termwidth}[\tw@\ut@parindent]

% Predefine lista de acrônimos
\NewDocumentCommand\ut@acronymtype{O{o} m m O{}}{%
  \define@key{ut@#2}{singular}{%
    \ut@declarenameedef{ut@#2singular}{}{##1}}
  \define@key{ut@#2}{plural}{%
    \ut@declarenameedef{ut@#2plural}{}{##1}}
  \define@key{ut@#2}{threshold}{%
    \ut@declarenamedef{ut@#2threshold}{}{##1}}
  \setkeys{ut@#2}{%
    singular=#2,
    plural={\@nameuse{ut@#2singular}s},
    threshold=15, #4}
  \newcounter{ut@#2}
  \newcounter{ut@#2@total}
  \ut@namedef{ext@ut@#2}{}{\ut@tocextension{#2}}
  \ut@newdimen{#2@width}[\ut@termwidth]
  \ut@namedef{ut@#2print}{O{} m m}{%
    \ifcsname ut@#2##3\endcsname
      \@nameuse{ut@#2##3##2}[##1]%
    \else\ifnum\@nameuse{ut@#2commandssize}>\z@
      \begingroup
        \@nameuse{ut@#2commandsenumerate}{\ut@commands}[ou]
        \ifnum\@nameuse{ut@#2commandssize}>\@ne
          \NewExpandableDocumentCommand\ut@message{}{Utilize os comandos}%
        \else
          \NewExpandableDocumentCommand\ut@message{}{Utilize o comando}%
        \fi
        \ut@error{\MFUsentencecase#1 \@nameuse{ut@#2singular} ##3 não foi definid#1}{%
          \ut@message\space\ut@commands\space para definir um\if#1aa\fi\space\@nameuse{ut@#2singular}}%
      \endgroup
    \fi\fi}
  \ut@namedef{ut@#2fullprint}{O{} m m}{%
    \@nameuse{ut@#2print}[##1]{meaning##2}{##3} (\@nameuse{ut@#2print}{##2}{##3})}
  \ut@namedef{ut@#2dynamicprint}{O{} m m}{%
    \begingroup
      \NewDocumentCommand\ut@print{}{ut@#2print}%
      \expandafter\ifx\csname ifut@#2##3iscommon\expandafter\endcsname\csname iftrue\endcsname\else
      \expandafter\ifx\csname ifut@#2##3\expandafter\endcsname\csname iftrue\endcsname\else
        \RenewDocumentCommand\ut@print{}{ut@#2fullprint}%
      \fi\fi
      \@nameuse{\ut@print}[##1]{##2}{##3}%
    \endgroup}
  \ut@namedef{#3}{}{\@nameuse{ut@#2dynamicprint}{}}
  \ut@namedef{#3p}{}{\@nameuse{ut@#2dynamicprint}{plural}}
  \ut@namedef{\MFUsentencecase#3}{}{\@nameuse{ut@#2dynamicprint}[\MFUsentencecase]{}}
  \ut@namedef{\MFUsentencecase#3p}{}{\@nameuse{ut@#2dynamicprint}[\MFUsentencecase]{plural}}
  \ut@namedef{a#3}{}{\@nameuse{ut@#2print}{}}
  \ut@namedef{a#3p}{}{\@nameuse{ut@#2print}{plural}}
  \ut@namedef{A#3}{}{\@nameuse{ut@#2print}[\MFUsentencecase]{}}
  \ut@namedef{A#3p}{}{\@nameuse{ut@#2print}[\MFUsentencecase]{plural}}
  \ut@namedef{s#3}{}{\@nameuse{ut@#2print}{meaning}}
  \ut@namedef{s#3p}{}{\@nameuse{ut@#2print}{meaningplural}}
  \ut@namedef{S#3}{}{\@nameuse{ut@#2print}[\MFUsentencecase]{meaning}}
  \ut@namedef{S#3p}{}{\@nameuse{ut@#2print}[\MFUsentencecase]{meaningplural}}
  \ut@namedef{#3c}{}{\@nameuse{ut@#2fullprint}{}}
  \ut@namedef{#3cp}{}{\@nameuse{ut@#2fullprint}{plural}}
  \ut@namedef{\MFUsentencecase#3c}{}{\@nameuse{ut@#2fullprint}[\MFUsentencecase]{}}
  \ut@namedef{\MFUsentencecase#3cp}{}{\@nameuse{ut@#2fullprint}[\MFUsentencecase]{plural}}
  \ut@newif{#2}
  \AtEndDocument{%
    \if@filesw
      \ifnum\value{ut@#2}>\z@
        \immediate\write\@mainaux{\global\expandafter\noexpand\csname ut@#2true\endcsname}
        \immediate\write\@mainaux{\global\expandafter\noexpand\csname ut@#2@width\endcsname\the\@nameuse{ut@#2@width}}
      \else
        \immediate\write\@mainaux{\global\expandafter\noexpand\csname ut@#2false\endcsname}
      \fi
    \fi}
  \ut@namedef{ext@ut@acronym@#2}{}{\ut@tocextension{#2.lst}}
  \addtocontents{\@nameuse{ext@ut@acronym@#2}}{%
    \protect\termslist{#2}{Lista de \@nameuse{ut@#2plural}}\protected@file@percent}
  \newstack{ut@#2commands}
  \ut@namedef{ut@#2}{m O{}}{%
    \define@key{ut@##1}{singular}{%
      \ut@declarenameedef{ut@##1singular}{}{####1}}
    \define@key{ut@##1}{plural}{%
      \ut@declarenameedef{ut@##1plural}{}{####1}}
    \setkeys{ut@##1}{%
      singular=##1,
      plural={\@nameuse{ut@##1singular}s}, ##2}
    \@nameuse{ut@#2commandspush}{\expandafter\protect\csname##1\endcsname}
    \newcounter{ut@##1}
    \ut@namedef{ext@ut@##1}{}{\ut@tocextension{##1}}
    \ut@nameedef{ut@##1@target}{}{##1}
    \ut@newdimen{##1@width}[\ut@termwidth]
    \ut@namedef{ut@##1@append}{m}{%
      \expandafter\ifx\csname ifut@#2####1\expandafter\endcsname\csname iffalse\endcsname
        \global\ut@true{#2####1}%
        \ifnum\value{ut@\@nameuse{ut@##1@target}}=\z@
          \@nameuse{ut@\@nameuse{ut@##1@target}@width}\ut@termwidth%
        \fi
        \begingroup
          \ut@newdimen{width}%
          \settowidth\ut@width{\@nameuse{ut@#2####1}\nobreakspace}%
          \ifdim\ut@width>\@nameuse{ut@\@nameuse{ut@##1@target}@width}%
            \global\@nameuse{ut@\@nameuse{ut@##1@target}@width}\ut@width%
          \fi
        \endgroup
        \stepcounter{ut@#2@total}%
        \stepcounter{ut@\@nameuse{ut@##1@target}}%
      \fi}
    \ut@namedef{##1}{m >{\TrimSpaces} m O{} >{\TrimSpaces} m O{}}{%
      \define@key{ut@#2####1@a}{plural}[]{%
        \expandafter\ifx\csname ifut@#2####1@ac\expandafter\endcsname\csname iftrue\endcsname
          \IfStrEq{########1}{}{%
            \ut@declarenamedef{ut@#2####1plural}{O{\@iden}}{%
        \@nameuse{ut@##1@append}{####1}%
              \hyperlink{ut@\@nameuse{ut@##1@target}.####1}{%
                \expandafter################1{{\@nameuse{ut@#2####1@af}{####2}}}}}}
          {%
            \ut@declarenamedef{ut@#2####1plural}{O{\@iden}}{%
          \@nameuse{ut@##1@append}{####1}%
              \hyperlink{ut@\@nameuse{ut@##1@target}.####1}{%
                \expandafter################1{{\@nameuse{ut@#2####1@af}{########1}}}}}}
        \else
          \IfStrEq{########1}{}{%
            \ut@declarenamedef{ut@#2####1plural}{o}{%
              \@nameuse{ut@##1@append}{####1}%
              \hyperlink{ut@\@nameuse{ut@##1@target}.####1}{{\@nameuse{ut@#2####1@af}{####2}}}}}
      {%
            \ut@declarenamedef{ut@#2####1plural}{o}{%
          \@nameuse{ut@##1@append}{####1}%
              \hyperlink{ut@\@nameuse{ut@##1@target}.####1}{{\@nameuse{ut@#2####1@af}{########1}}}}}
        \fi}
      \define@key{ut@#2####1@a}{formato}{%
        \ut@declarenameedef{ut@#2####1@af}{}{########1}}
      \define@key{ut@#2####1@a}{semplural}[]{%
        \setkeys{ut@#2####1@a}{plural}}
      \define@key{ut@#2####1@a}{naomaiusculizar}[]{%
        \global\ut@false{#2####1@ac}}
      \define@key{ut@#2####1@m}{plural}[]{%
        \expandafter\ifx\csname ifut@#2####1@mc\expandafter\endcsname\csname iftrue\endcsname
          \IfStrEq{########1}{}{%
            \ut@declarenamedef{ut@#2####1meaningplural}{O{\@iden}}{%
              \expandafter################1{{\@nameuse{ut@#2####1@mf}{####4}}}}}
          {%
            \ut@declarenamedef{ut@#2####1meaningplural}{O{\@iden}}{%
              \expandafter################1{{\@nameuse{ut@#2####1@mf}{########1}}}}}
        \else
          \IfStrEq{########1}{}{%
            \ut@declarenamedef{ut@#2####1meaningplural}{o}{{\@nameuse{ut@#2####1@mf}{####4}}}}
          {%
            \ut@declarenamedef{ut@#2####1meaningplural}{o}{{\@nameuse{ut@#2####1@mf}{########1}}}}
        \fi}
      \define@key{ut@#2####1@m}{formato}{%
        \ut@declarenameedef{ut@#2####1@mf}{}{########1}}
      \define@key{ut@#2####1@m}{semplural}[]{%
        \setkeys{ut@#2####1@m}{plural}}
      \define@key{ut@#2####1@m}{naomaiusculizar}[]{%
        \global\ut@false{#2####1@mc}}
      \ut@newiftrue{#2####1@ac}
      \ut@newiftrue{#2####1@mc}
      \setkeys{ut@#2####1@a}{%
        plural=####2s,
        formato=\@iden, ####3}
      \setkeys{ut@#2####1@m}{%
        plural=####4s,
        formato=\@iden, ####5}
      \expandafter\ifx\csname ifut@#2####1@ac\expandafter\endcsname\csname iftrue\endcsname
        \ut@namedef{ut@#2####1}{O{\@iden}}{%
          \@nameuse{ut@##1@append}{####1}%
          \hyperlink{ut@\@nameuse{ut@##1@target}.####1}{%
            \expandafter########1{{\@nameuse{ut@#2####1@af}{####2}}}}}
      \else
        \ut@namedef{ut@#2####1}{o}{%
          \@nameuse{ut@##1@append}{####1}%
          \hyperlink{ut@\@nameuse{ut@##1@target}.####1}{{\@nameuse{ut@#2####1@af}{####2}}}}
      \fi
      \expandafter\ifx\csname ifut@#2####1@mc\expandafter\endcsname\csname iftrue\endcsname
        \ut@namedef{ut@#2####1meaning}{O{\@iden}}{%
          \expandafter########1{{\@nameuse{ut@#2####1@mf}{####4}}}}
      \else
        \ut@namedef{ut@#2####1meaning}{o}{{\@nameuse{ut@#2####1@mf}{####4}}}
      \fi
      \ut@newif{#2####1}
      \AtEndDocument{%
        \expandafter\ifx\csname ifut@#2####1\expandafter\endcsname\csname iftrue\endcsname
          \addtocontents{\@nameuse{ext@ut@\@nameuse{ut@##1@target}}}{%
            \protect\termline{ut@\@nameuse{ut@##1@target}}{####1}{%
              \expandafter\ifx\csname ifut@#2####1@ac\expandafter\endcsname\csname iftrue\endcsname
                \expandafter\MFUsentencecase{{\@nameuse{ut@#2####1@af}{####2}}}%
              \else
                {\@nameuse{ut@#2####1@af}{####2}}%
              \fi}%
            {%
              \expandafter\ifx\csname ifut@#2####1@mc\expandafter\endcsname\csname iftrue\endcsname
                \expandafter\MFUsentencecase{{\@nameuse{ut@#2####1@mf}{####4}}}%
              \else
                {\@nameuse{ut@#2####1@mf}{####4}}%
              \fi}%
            {%
              ut@\@nameuse{ut@##1@target}.####1}\protected@file@percent}
        \fi}}
    \ut@namedef{##1comum}{m}{%
      \ut@newiftrue{#2####1iscommon}
      \@nameuse{##1}{####1}}
    \ut@newiftrue{##1}
    \AtEndDocument{%
      \if@filesw
        \ut@newif{shouldlist}
        \ifnum\value{ut@#2@total}>\z@
          \ifnum\value{ut@##1}=\value{ut@#2@total}
            \ut@shouldlisttrue
          \else
            \ifnum\value{ut@##1}<\@nameuse{ut@#2threshold}\else
            \ifnum\inteval{\value{ut@#2@total}-\value{ut@##1}}<\@nameuse{ut@#2threshold}\else
              \ut@shouldlisttrue
            \fi\fi
          \fi
        \fi
        \ifut@shouldlist
          \immediate\write\@mainaux{\global\expandafter\noexpand\csname ut@##1true\endcsname}
          \immediate\write\@mainaux{\global\expandafter\noexpand\csname ut@##1@width\endcsname\the\@nameuse{ut@##1@width}}
          \immediate\write\@mainaux{\gdef\expandafter\noexpand\csname ut@##1@target\endcsname{##1}}
        \else\ifnum\value{ut@\@nameuse{ut@##1@target}}>\z@\expandafter\ifx\csname ifut@#2\expandafter\endcsname\csname iftrue\endcsname\else
          \immediate\write\@mainaux{\global\expandafter\noexpand\csname ut@#2true\endcsname}
        \fi\fi
          \immediate\write\@mainaux{\global\expandafter\noexpand\csname ut@##1false\endcsname}
          \immediate\write\@mainaux{\gdef\expandafter\noexpand\csname ut@##1@target\endcsname{#2}}
        \fi
      \fi}
    \addtocontents{\@nameuse{ext@ut@acronym@#2}}{%
      \protect\termslist{##1}{Lista de \@nameuse{ut@##1plural}}\protected@file@percent}}
  \AtBeginDocument{\ut@toc{acronym@#2}}}

% Define as listas de abreviaturas e siglas
\ut@acronymtype{acronimo}{ac}[%
  singular=acrônimo,
  plural=abreviaturas e siglas]
\ut@acronimo{abreviatura}
\ut@acronimo{sigla}

% Controla a ordem na qual os símbolos são listados
\NewDocumentCommand\aparicao{}{aparição}
\NewDocumentCommand\definicao{}{definição}

% Predefine lista de símbolos
\NewDocumentCommand\ut@symboltype{m m O{o} m m}{%
  \newcounter{ut@#1}
  \ut@namedef{ut@#1@queue}{m m m}{%
    \AtEndDocument{%
      \expandafter\ifx\csname ifut@#1##1\expandafter\endcsname\csname iftrue\endcsname
        \addtocontents{\@nameuse{ext@ut@#1}}{%
          \protect\termline{ut@#1}{##1}{##2}{\MFUsentencecase##3}{ut@#1.##1}\protected@file@percent}
      \fi}}
  \ut@newdimen{#1@width}[\ut@termwidth]
  \ut@namedef{ut@#1@append}{m m m}{%
    \expandafter\ifx\csname ifut@#1##1\expandafter\endcsname\csname iffalse\endcsname
      \global\ut@true{#1##1}%
      \ifnum\value{ut@#1}=\z@
        \@nameuse{ut@#1@width}\ut@termwidth%
      \fi
      \begingroup
        \ut@newdimen{width}%
        \settowidth\ut@width{\@nameuse{ut@#1##1}\nobreakspace}%
        \ifdim\ut@width>\@nameuse{ut@#1@width}
          \global\@nameuse{ut@#1@width}\ut@width%
        \fi
      \endgroup
      \stepcounter{ut@#1}%
      \ifut@symbolsbyappearance
        \@nameuse{ut@#1@queue}{##1}{##2}{##3}%
      \fi
    \fi}
  \ut@namedef{ext@ut@#1}{}{\ut@tocextension{#1}}
  \ut@namedef{#1}{m >{\TrimSpaces} m >{\TrimSpaces} m >{\TrimSpaces} O{##3s}}{%
    \ut@namedef{ut@#1##1}{O{}}{%
      \@nameuse{ut@#1@append}{##1}{##2}{##3}%
      \hyperlink{ut@#1.##1}{\expandafter####1##2}}
    \ut@namedef{ut@#1##1meaning}{O{}}{\expandafter####1##3}
    \ut@namedef{ut@#1##1meaningplural}{O{}}{\expandafter####1##4}
    \ut@newif{#1##1}
    \AtBeginDocument{%
      \ifut@symbolsbyappearance\else
        \@nameuse{ut@#1@queue}{##1}{##2}{##3}
      \fi}}
  \ut@namedef{ut@#1print}{O{} m m}{%
    \ifcsname ut@#1##3\endcsname
      \@nameuse{ut@#1##3##2}[##1]%
    \else
      \ut@error{\MFUsentencecase#3 #4 ##3 não foi definid#3}{%
        Utilize o comando \expandafter\protect\csname#1\endcsname\space para definir um\if#3aa\fi\space #4}
    \fi}
  \ut@namedef{#2}{}{\@nameuse{ut@#1print}{}}
  \ut@namedef{s#2}{}{\@nameuse{ut@#1print}{meaning}}
  \ut@namedef{s#2p}{}{\@nameuse{ut@#1print}{meaningplural}}
  \ut@namedef{S#2}{}{\@nameuse{ut@#1print}[\MFUsentencecase]{meaning}}
  \ut@namedef{S#2p}{}{\@nameuse{ut@#1print}[\MFUsentencecase]{meaningplural}}
  \ut@newif{#1}
  \AtEndDocument{%
    \if@filesw
      \ifnum\value{ut@#1}>\z@
        \immediate\write\@mainaux{\global\expandafter\noexpand\csname ut@#1true\endcsname}
        \immediate\write\@mainaux{\global\expandafter\noexpand\csname ut@#1@width\endcsname\the\@nameuse{ut@#1@width}}
      \else
        \immediate\write\@mainaux{\global\expandafter\noexpand\csname ut@#1false\endcsname}
      \fi
    \fi}
  \AtBeginDocument{\ut@tocsection{#1}{#5}}}

% Define a lista de símbolos
\ut@symboltype{simbolo}{si}{símbolo}{Lista de símbolos}

% Predefine tipo de seção
\NewDocumentCommand\ut@sectiontype{m O{} m O{}}{%
  \IfBlankTF{#2}{%
    \newcounter{ut@#1}
    \ut@namedef{toclevel@ut@#1}{}{1}
    \ut@renewnameedef{theut@#1}{}{\arabic{ut@#1}}}
  {%
    \newcounter{ut@#1}[ut@#2]
    \ut@namedef{toclevel@ut@#1}{}{\inteval{\@nameuse{toclevel@ut@#2}+\@ne}}
    \ut@renewnameedef{theut@#1}{}{\@nameuse{theut@#2}.\arabic{ut@#1}}}
  \ut@namedef{ut@#1style}{}{#4}
  \ut@nameedef{ut@#1name}{}{#3}
  \ut@namedef{l@ut@#1}{}{\ut@dottedtocline[#4]}
  \ut@namedef{#1}{>{\TrimSpaces} m}{\ut@section{ut@#1}{#4}{##1}}}

% Define todos os níveis de seção
\ut@sectiontype{capitulo}{capítulo}[\bfseries\MakeUppercase]
\ut@sectiontype{secao}[capitulo]{seção}[\MakeUppercase]
\ut@sectiontype{subsecao}[secao]{subseção}[\bfseries]
\ut@sectiontype{subsubsecao}[subsecao]{\ut@subsecaoname}
\ut@sectiontype{subsubsubsecao}[subsubsecao]{\ut@subsubsecaoname}[\itshape]

% Sumário
\AtBeginDocument{%
  \ut@false{resourceslist}
  \RenewDocumentCommand\bookmarklevel@ut@frontchapter{}{1}
  \cleardoublepage
  \ut@frontchapter{sumario}{Sumário}
  \ut@toc{sumario}
  \cleardoublepage

  % Numeração de páginas
  \pagestyle{plain}
  \RenewExpandableDocumentCommand\thepage{}{\arabic{page}}

  % Recuo de primeira linha
  \parindent\ut@parindent}

% Parâmetros de posicionamento dos floats
\RenewDocumentCommand\textfraction{}{0.1}
\RenewDocumentCommand\topfraction{}{\fpeval{1-\textfraction}}
\RenewDocumentCommand\floatpagefraction{}{\fpeval{\topfraction-\textfraction}}

% Espaçamento entre um float e os elementos ao seu redor
\floatsep\dimeval{\baselineskip+\ut@lineheight}
\textfloatsep\floatsep
\intextsep\floatsep

% Ajusta o espaçamento após floats posicionados no topo da página.
\ut@newskip{prevdepth}
\patchcmd{\@cflt}{%
  \vskip\textfloatsep}
{%
  \vspace{\dimeval{\textfloatsep-\ut@prevdepth}}}{}{}

% Ajusta o espaçamento após floats posicionados no meio do texto.
\patchcmd{\@addtocurcol}{%
  \vskip\intextsep
  \ifnum\outputpenalty<-\@Mii
    \vskip-\parskip
  \fi}
{%
  \aftergroup\vspace\aftergroup\baselineskip
  \aftergroup\nointerlineskip}{}{}

% Conjunto de floats
\ut@newif{withinfloatset}
\NewDocumentEnvironment{conjunto}{m >{\TrimSpaces} m}{%
  \ifx\@captype\@undefined
    \@ifundefined{ftype@ut@#1}{%
      \ut@error{Ambiente {#1} não definido}{%
        Utilize um ambiente de float previamente definido ao declarar conjuntos de floats}}
  \else
    \ut@error{Conjunto de floats declarado dentro de um ambiente de \@nameuse{\@captype name}}{%
      Declare conjuntos de floats fora de ambientes de float, como de ilustração, quadro ou tabela}
  \fi
  \global\ut@true{withinfloatset}
  \begin{#1}{#2}{}}
{%
  \end{#1}
  \global\ut@false{withinfloatset}}

% Elemento de um conjunto de floats
\ut@newif{withinfloatelement}
\NewDocumentEnvironment{elemento}{>{\TrimSpaces} m >{\TrimSpaces} m m}{%
  \ifut@withinfloatset\else
    \ut@error{Elemento de float declarado fora de um conjunto de floats}{%
      Declare elementos de float apenas dentro de conjuntos de floats}
  \fi
  \global\ut@true{withinfloatelement}
  \begin{minipage}{#3}
    \ut@caption{#1}
    \vspace{\dimeval{\ut@floattextskip-\prevdepth}}}
{%
    \ut@source{#2}
  \end{minipage}
  \global\ut@false{withinfloatelement}}

% Espaço entre um float e os textos da legenda e da fonte
\ut@newdimen{floattextskip}[6\p@]

% Legenda dos floats
\NewDocumentCommand\ut@caption{m}{%
  \ifx\@captype\@undefined\else
    \ifcsname\@captype parent\endcsname
      \DeclareExpandableDocumentCommand\ut@captypetotal{}{\@nameuse{\@captype parent}@total}%
      \expandafter\ifx\csname if\@captype\expandafter\endcsname\csname iftrue\endcsname
        \DeclareCommandCopy\ut@captype\@captype
      \else
        \DeclareExpandableDocumentCommand\ut@captype{}{\@nameuse{\@captype parent}}%
      \fi
    \else
      \DeclareExpandableDocumentCommand\ut@captypetotal{}{\@captype @total}%
      \DeclareCommandCopy\ut@captype\@captype
    \fi
    \ifut@withinfloatelement
      \begingroup
        \ut@singlespacing
        \ut@blankline
      \endgroup
      \vspace{-\ut@linedepth}%
      \refstepcounter{\ut@captype element}%
      \vspace\ut@linedepth
      \begingroup
        \footnotesize
        \ut@singlespacing
        \interlinepenalty\@M
        \alph{\ut@captype element})\nobreakspace#1.
      \endgroup
    \else
      \NewExpandableDocumentCommand\ut@captiontext{}{\ut@labeledtitle\ut@captype\nobreakspace#1}%
      \stepcounter\ut@captypetotal
      \vspace{-\ut@linedepth}%
      \refstepcounter\ut@captype
      \vspace\ut@linedepth
      \begingroup
        \ut@singlespacing
        \interlinepenalty\@M
        \ut@captiontext.
      \endgroup
      \addcontentsline{\@nameuse{ext@\ut@captype}}{\ut@captype}{\ut@captiontext}%
    \fi
    \par\nobreak
  \fi}

% Fonte dos floats
\NewDocumentCommand\ut@source{m}{%
  \ifx\@captype\@undefined\else
    \par\nobreak
    \nointerlineskip
    \vspace\ut@floattextskip
    \begingroup
      \footnotesize
      \ut@singlespacing
      \interlinepenalty\@M
      Fonte: #1.
    \endgroup
    \par\nobreak
    \global\ut@prevdepth\prevdepth
  \fi}

% Predefine tipo de lista de tópicos
\NewDocumentCommand\ut@listlabelleftaligned{m}{#1\hfill}
\NewDocumentCommand\ut@listtype{m O{} m O{}}{%
  \newcounter{ut@#1depth}
  \NewDocumentEnvironment{#1}{}{%
    \ifnum\value{ut@#1depth}=\@listdepth
      \stepcounter{ut@#1depth}
    \else
      \ut@error{Tipos de lista não compatíveis}{%
        O ambiente {#1} só pode ser aninhado a ele mesmo}
    \fi
    \ifcsname c@ut@#1\romannumeral\value{ut@#1depth}\endcsname\else
      \newcounter{ut@#1\romannumeral\value{ut@#1depth}}
    \fi
    \list{\ut@coalesce{ut@#1\romannumeral\@listdepth}{#2}}{%
      \ifnum\@listdepth>#3
        \@toodeep
      \else\ifnum\@listdepth>\@ne
        \topsep\z@
        \leftmargin0.8\parindent
      \else
        \topsep\baselineskip
        \leftmargin\parindent
      \fi\fi
      \listparindent\parindent
      \labelwidth0.4\parindent
      \ut@coalesce{ut@#1label\romannumeral\@listdepth}{#4}
      \usecounter{ut@#1\romannumeral\@listdepth}}}
  {%
    \endlist
    \addtocounter{ut@#1depth}{-1}}}

% Lista de marcadores
\ut@listtype{marcadores}[\bullet]{3}[%
  \ut@newdimen{labelwidth}
  \settowidth\ut@labelwidth\bullet
  \advance\labelwidth0.5\ut@labelwidth
  \RenewCommandCopy\makelabel\ut@listlabelleftaligned]
\ut@undef\itemize

% Alíneas e subalíneas
\ut@listtype{alineas}{2}
\NewDocumentCommand\ut@alineasi{}{\alph{ut@alineasi})}
\NewDocumentCommand\ut@alineaslabeli{}{%
  \advance\labelwidth0.1\parindent
  \RenewCommandCopy\makelabel\ut@listlabelleftaligned}
\NewDocumentCommand\ut@alineasii{}{\textemdash\nobreakspace}
\NewDocumentCommand\ut@alineaslabelii{}{\advance\labelwidth\labelwidth}
\ut@undef\enumerate

% Ajusta os espaços antes e depois de ambientes matemáticos
\abovedisplayskip\baselineskip
\belowdisplayskip\baselineskip
\abovedisplayshortskip\abovedisplayskip
\belowdisplayshortskip\belowdisplayskip

% Automatiza a referenciação múltipla de labels.
\newstack{ut@autoref}
\NewCommandCopy\ut@autoref\autoref
\RenewDocumentCommand\autoref{>{\SplitList{,}} m}{%
  \ProcessList{#1}{\ut@autorefpush}%
  \begingroup
    \ifnum\ut@autorefsize>\@ne
      \newcount\@i
      \loop\ifnum\@i<\ut@autorefsize
        \advance\@i\@ne\relax
        \ut@autorefget\@i\ut@autoreflabel
        \ifcsname r@\ut@autoreflabel\endcsname
          \def\ut@autorefsetname####1.####2\\{%
            \ifnum\@i>\@ne
              \IfStrEq\ut@autorefname{####1}{}{%
                \ut@error{Tipos diferentes de rótulos referenciados}{%
                  Referencie rótulos de tipos iguais quando utilizar o comando \protect\autoref}}%
            \else
              \NewExpandableDocumentCommand\ut@autorefname{}{####1}%
            \fi}%
          \edef\ut@labelref{\@nameuse{r@\ut@autoreflabel}}%
          \edef\ut@label{%
            \expandafter\@fourthoffive\ut@labelref\@empty\@empty\@empty}%
          \expandafter\ut@autorefsetname\ut@label.\\%
        \fi
      \repeat
      \ifx\ut@autorefname\@undefined
        ??%
      \else\ifcsname\ut@autorefname pluralname\endcsname
        \@nameuse{\ut@autorefname pluralname}%
      \else
        ??%
      \fi\fi
      \ut@autorefenumerate\ut@autoreftext[e][\ref]%
      \nobreakspace\ut@autoreftext
      \ut@autorefreset
    \else
      \ut@autorefpop\ut@autoreflabel
      \ut@autoref\ut@autoreflabel
    \fi
  \endgroup}

% Cita a própria autoria do trabalho.
\NewDocumentCommand\ut@citeme{m}{\ut@namedef{#1}{O{\data}}}
\ut@citeme{citeme}{(\ut@citemename, #1)}
\ut@citeme{textciteme}{\ut@citemename{} (#1)}
\ut@citeme{Textciteme}{\MFUsentencecase\ut@citemename{} (#1)}

% Sinal de supressão textual
\NewDocumentCommand\supressao{}{\hb@xt@\ut@linesize{[\hss...\hss]}}

% Ambiente de citação longa
\NewDocumentEnvironment{citacao}{}{%
  \par
  \nointerlineskip
  \ut@blankskip
  \begingroup
    \leftskip4cm\relax
    \footnotesize
    \ut@singlespacing
    \interlinepenalty\@M
    \noindent\ignorespaces}
{%
    \par
  \endgroup
  \par
  \nointerlineskip
  \ut@blankskip}

% Espaço entre as notas de rodapé e o texto
\begingroup
  \ut@singlespacing
  \global\skip\footins\@ne\baselineskip\@plus1fill\@minus\p@
\endgroup

% Filete separador das notas de rodapé
\RenewDocumentCommand\footnoterule{}{%
  \kern-\ut@interlineskip
  \hrule\@width5cm\kern\dimeval{\ut@interlineskip-\p@}}

% Nota de rodapé
\NewCommandCopy\ut@makefnmark\@makefnmark
\RenewDocumentCommand\@makefnmark{}{%
  \tmspace+\thinmuskip{0.05em}\ut@makefnmark}
\NewDocumentCommand\@makefntext{}{%
  \ut@singlespacing
  \noindent\ut@makefnmark\nobreakspace}
\@addtoreset{footnote}{ut@capitulo}

% Inibe o aviso de que não há referências
\RenewCommandCopy\blx@warn@bibempty\relax

% Define capítulo pós-textual
\NewDocumentCommand\ut@backchapter{m}{\ut@section[cap:#1]{ut@capitulo}{\ut@capitulostyle}}

% Configura o capítulo das referências
\defbibheading{bibliography}{%
  \ut@backchapter{referencias}{Referências}
  \vspace\ut@interlineskip}

% Entre-linhas simples nas referências
\RenewDocumentCommand\bibfont{}{%
  \ut@singlespacing
  \bibitemsep\baselineskip}

% Facilita quebras de linha de URLs das referências
\setcounter{biburlbreakpenalty}{9}
\setcounter{biburlbigbreakpenalty}{9}

% Referências
\AtEndDocument{%
  % Recuo de primeira linha
  \parindent\z@

  % Referências
  \printbibliography}

% Predefine capítulo pós-textual alfabético
\NewDocumentCommand\ut@backchaptertype{m O{#1} m}{%
  \newcounter{ut@#1}
  \ut@namedef{toclevel@ut@#1}{}{2}
  \ut@renewnameedef{theut@#1}{}{\Alph{ut@#1}}
  \ut@nameedef{ut@#1name}{}{#2}
  \ut@namedef{l@ut@#1}{}{\ut@dottedtocline[\ut@capitulostyle]}
  \ut@namedef{ext@ut@#1}{}{\ut@tocextension{#1}}
  \ut@namedef{ut@#1chapter}{}{%
    \cleardoublepage
    \ifnum\value{ut@#1}=\z@
      \ut@pdfpagebookmark{#3}
    \fi
    \ut@section{ut@#1}[\ut@labeledtitle]{\ut@capitulostyle}}}

% Predefine tipo de acessório
\NewDocumentCommand\ut@attachmenttype{m m O{#2} m}{%
  \ut@backchaptertype{#2}[#3]{#4}
  \ut@namedef{#1content}{O{} m}{%
    \@nameuse{ut@#2chapter}{##2}
    \IfBlankF{##1}{\label{##1}}}
  \ut@namedef{#2}{O{} >{\TrimSpaces} m m}{%
    \addtocontents{\@nameuse{ext@ut@#2}}{%
      \expandafter\protect\csname#1content\endcsname[##1]{##2}{##3}\protected@file@percent}}}

% Define apêndice e anexo
\ut@attachmenttype{appendix}{apendice}[apêndice]{Apêndices}
\ut@attachmenttype{annex}{anexo}{Anexos}

% Apêndices e anexos
\AtEndDocument{%
  \ut@toc{apendice}
  \ut@toc{anexo}}

% definição de uma lista não ordenada
\newenvironment{myitemize}{%
  \begin{list}{$\bullet$}{%
    \setlength{\itemsep}{0pt}%
    \setlength{\parsep}{0pt}%
    \setlength{\topsep}{0pt}%
    \setlength{\partopsep}{0pt}%
    \setlength{\leftmargin}{1.5em}%
    \setlength{\labelwidth}{1em}%
    \setlength{\labelsep}{0.5em}%
  }%
}{%
  \end{list}%
}
