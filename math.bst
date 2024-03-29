%%-----------------------------------------------
%% 	Bibliography style math
%% 	Curt McMullen January 1989
%%
%%	Modified by Nathan Dunfield and Martin Pergler 1997-2023.
%%
%%-----------------------------------------------
FUNCTION {print.ver}  % executed below after READ
%%
 {"You are using math.bst v1.7." top$ }
                      % Future revisions should change version # inside
%%
%% -VERSION HISTORY----------
%%
%%
%% [ver 1.7] Modified by Nathan Dunfield 2023/12 so that clicking on
%%           the article title gotes to HIDDENURL if it exists, else
%%           the DOI.  If the URL matches the DOI, do not include the
%%           DOI to reduce clutter.
%%
%% [ver 1.6] Modified by Nathan Dunfield 2011/3 to ignore the DOI field
%%           in favor of using the HIDDENURL field since that's what MathSciNet
%%           always gives you.
%%
%%           Added support for MR numbers with links
%%
%% [ver 1.5] Modified by Nathan Dunfield 2010/10 to change the alpha
%%           label formating to use the full name if it's four characters.
%%
%% [ver 1.4] Modified by Nathan Dunfield 2010/2 to add hyperref support,
%%	     following utphys.bst.
%%
%% In particular, the following fields are supported:
%%
%%   EPRINT, with typical values {arXiv:math.GT/9801045}
%%   {arXiv:math.GT/9801045} is added at the end of the entry.
%%
%%   DOI, with typical value {10.1090/S0025-5718-99-01036-4} is turned into
%%   a hyperlink for the title via http://dx.doi.org but not otherwise printed.
%%
%%   URL, with typical value {http://dunfield.info} is added at the end
%%   of the entry.
%%
%%   HIDDENURL, is turned into a hyperlink for the title but not
%%   actually printed.
%%
%%
%% [ver 1.3] Modified by Nathan Dunfield 2005/10 to add an eprint field.
%%
%% [ver 1.2] Modified Martin Pergler Mar 99 to
%% a) insert space between journal volume number and year (looks nicer
%%    and makes TeX linebreaking algorithm happier).
%% b) comment out computing journal macros from some ancestor version
%% c) Impose version numbering making this 1.2, deeming Nathan's mod 1.1, and
%%    original McMullen version 1.0
%% d) Added function print.ver to print version number at start
%%    (since several versions are in use at our site). Future revisions
%%    should of course change its output!!!!
%% e) Added support for url field (for preprints, etc on someone's web page)
%%    to type article.
%%          use URL={http://blah/blah/bleat.pdf} in bib entry
%%    Typeset in tt type with no puncutation (. or ,) afterwards
%%    at very end of bib entry (after note if any)
%%    Limitation: URL cannot contain | else \verb| | gets confused.
%%    At some point someone could add support for e-print servers.
%% -----------
%% Modified
%% by Nathan Dunfield Dec 1997
%% a) change to line in format.names so that first names
%%    will be abbreviated.
%% ----------
%%
%% Here is a brief description of the math bibliographystyle.  It is
%% designed to provide an alternative to the plain and alpha styles
%% which is more commonly used in mathematics; and to correct certain
%% quirks of those styles.
%%
%% 0.  To use the style, you simply use bibtex as usual but specify
%% \bibliographystyle{math}.
%%
%% 1.  You can specify alphanumeric keys for papers.  Thus a typical entry in
%% you .bib file might read
%%
%% @article{Harrison:modules,
%% 	key="Har",
%% 	author="J. Harrison",
%% 	title="Rings of modules",
%% 	journal="J. of Modules",volume="21",year="1982",pages="11-12"}
%%
%% This then appears in the bibliography as
%%
%% [Har]  J. Harrison.  Rings of modules.  J. of Modules (<-italicized) 21 (1982), 11-12.
%%
%% and your citations are rendered as e.g. "for further information, see [Har]".
%%
%% 2.  If no key is specified, one is concocted from the name.  If several
%% references are made to different bibliography entries with the same key
%% (e.g. several papers by Harrison) they become numbered [Har1], [Har2], etc.
%%
%% 3.  The standard bibliography styles have an annoying decapitalization ``feature''.
%% In math style, what you write is what appears.
%%
%% 4.  If you prefer the style
%%
%% [Har]  J. Harrison.  Rings of modules.  J. of Modules (italicized) 21:11-12, 1982.
%%
%% it can be invoked by using @article.plain (instead of @article) in the
%% bibliography database entry.
%%
%% 5.  Bibliography entries are sorted first by name, then by year, then by title.
%% Preprints can be included by specifying e.g. journal="Preprint", and leaving
%% out the year entry.  They will appear after all dated entries by the same author.
%%
%% 6.  (July 1995).  To obtain these advantages but with
%% numerical keys, you may invoke the bibliographystyle
%% math.num.  It differs from math only in that the
%% optional label in the bibliography entry is suppressed.
%
%---------------------------------------------------
%
%  Modified from alpha.bst, December 1988.
%  Modified for new version of BibTeX, May 1989
%  Bug fixed, 25 Feb 1991:
%       int.to.chr$/int.to.str$;
%	to produce keys of the form %	Name10, Name11, etc.
%
%  Bug fixed, 29 Jan 1991:
%      in function key.author.editor.label.
%
%  	SUMMARY OF MODIFICATIONS
%
%    Uses the "key" entry to give alphanumeric key to paper.
%    Multiple names result in Name1, Name2, etc.
%    Otherwise key is built from author's name.
%    Article style:  J. name vol(year), pages.
%    Function format.vol.year.pages used for article style.
%    Puts volume number in bold face.
%    Format.title:   No decapitalization in titles.
%    Old Article Style renamed article.plain.
%    Old title formatter renamed format.ctitle.
%    Sorts by name, then year, then title.
%    Does not decapitilize keys when sorting.  Thus [Ab], [AB] instead of
%    [Ab1], [AB2].
%    Uses the year 9999 if no year is given.  This lists
%    preprints AFTER published work.
%

ENTRY
  { address
    author
    booktitle
    chapter
    doi
    edition
    editor
    eprint
    hiddenurl
    howpublished
    institution
    journal
    key
    month
    mrnumber
    note
    number
    organization
    pages
    publisher
    school
    series
    title
    type
    url
    volume
    year
    archive
    archivePrefix
    primaryClass
  }
  {}
  { label extra.label sort.label }

INTEGERS { output.state before.all mid.sentence after.sentence after.block }
% Starting in v.1.2, also use before.all when don't want any puctuation
% after last entry (eg. URL). Should rename variables to bear this in
% account.

FUNCTION {init.state.consts}
{ #0 'before.all :=
  #1 'mid.sentence :=
  #2 'after.sentence :=
  #3 'after.block :=
}

STRINGS { s t bother }

FUNCTION {output.nonnull}
{ 's :=
  output.state mid.sentence =
    { ", " * write$ }
    { output.state after.block =
	{ add.period$ write$
	  newline$
	  "\newblock " write$
	}
	{ output.state before.all =
	    'write$
	    { add.period$ " " * write$ }
	  if$
	}
      if$
      mid.sentence 'output.state :=
    }
  if$
  s
}

%  Supress comma
FUNCTION {output.nonnull.nocomma}
{ 's :=
  output.state mid.sentence =
    { " " * write$ }
    { output.state after.block =
	{ add.period$ write$
	  newline$
	  "\newblock " write$
	}
	{ output.state before.all =
	    'write$
	    { add.period$ " " * write$ }
	  if$
	}
      if$
      mid.sentence 'output.state :=
    }
  if$
  s
}

FUNCTION {output}
{ duplicate$ empty$
    'pop$
    'output.nonnull
  if$
}

%  Suppress comma
FUNCTION {output.nocomma}
{ duplicate$ empty$
    'pop$
    'output.nonnull.nocomma
  if$
}

FUNCTION {output.check}
{ 't :=
  duplicate$ empty$
    { pop$ "empty " t * " in " * cite$ * warning$ }
    'output.nonnull
  if$
}

FUNCTION {output.bibitem}
{ newline$
  "\bibitem[" write$
  label write$
  "]{" write$
  cite$ write$
  "}" write$
  newline$
  ""
  before.all 'output.state :=
}

FUNCTION {fin.entry}
{
% Changed v1.2. Next three lines were just one line add.period$
  output.state before.all =
    'skip$          % Do nothing if no punct desired at end.
    { add.period$ } % else put period
  if$
  write$
  newline$
}

FUNCTION {new.block}
{ output.state before.all =
    'skip$
    { after.block 'output.state := }
  if$
}

FUNCTION {new.sentence}
{ output.state after.block =
    'skip$
    { output.state before.all =
	'skip$
	{ after.sentence 'output.state := }
      if$
    }
  if$
}

FUNCTION {not}
{   { #0 }
    { #1 }
  if$
}

FUNCTION {and}
{   'skip$
    { pop$ #0 }
  if$
}

FUNCTION {or}
{   { pop$ #1 }
    'skip$
  if$
}

FUNCTION {new.block.checka}
{ empty$
    'skip$
    'new.block
  if$
}

FUNCTION {new.block.checkb}
{ empty$
  swap$ empty$
  and
    'skip$
    'new.block
  if$
}

FUNCTION {new.sentence.checka}
{ empty$
    'skip$
    'new.sentence
  if$
}

FUNCTION {new.sentence.checkb}
{ empty$
  swap$ empty$
  and
    'skip$
    'new.sentence
  if$
}

FUNCTION {field.or.null}
{ duplicate$ empty$
    { pop$ "" }
    'skip$
  if$
}

%  Give the year 9999 to publications with no date.
FUNCTION {field.or.late}
{ duplicate$ empty$
    { pop$ "9999" }
    'skip$
  if$
}

FUNCTION {emphasize}
{ duplicate$ empty$
    { pop$ "" }
    { "{\em " swap$ * "}" * } % stay latex209 compatible for now
                              % comment added v.1.2
  if$
}

% Make boldface (for volume number)
FUNCTION {bold}
{ duplicate$ empty$
    { pop$ "" }
    { "{\bf " swap$ * "}" * } % eventually change to \textbf, but
                              % for now stay latex209 compatible
                              % comment added v1.2
  if$
}

FUNCTION {format.archive}
{
  archivePrefix empty$
      { "" }
      { archivePrefix ":" *}
  if$
}

FUNCTION {format.primaryClass}
{
  primaryClass empty$
      { "" }
      { " [" primaryClass * "]" *}
  if$
}

FUNCTION {format.eprint}
{ eprint empty$
     { "" }
     { archive empty$
          {"\href{http://arxiv.org/abs/" eprint * "}" *
             "{{\tt " * format.archive * eprint *
              format.primaryClass * "}}" *}
          {"\href{" archive *  "/" * eprint * "}" *
             "{{\tt " * format.archive * eprint *
              format.primaryClass * "}}" *}
       if$
     }
     if$
}

FUNCTION {url.doi}
{ doi empty$
  { "" }
  { "https://doi.org/" doi * }
  if$
}

FUNCTION {add.doi}
{ duplicate$ empty$
   { skip$ }
   { "\href{" url.doi * "}{" * swap$ * "}" * }
  if$
}


FUNCTION {add.hiddenurl}
{ duplicate$ empty$
    { skip$ }
    { hiddenurl empty$
        { add.doi }
        { "\href{"  hiddenurl  * "}{" * swap$ * "}" * }
      if$
    }
  if$
}

% Format a URL using hyperref.
FUNCTION {output.url}
{
  duplicate$ empty$
    { pop$ }
    { duplicate$ url.doi =
    { pop$ }
    {"\url{" swap$ * "} " *  % URLs shouldn't have a | in them
        output.nonnull
        before.all 'output.state := % Don't put periods or commas
                                   % afterwards, so pretend we're
        % right after citation key
    }
     if$
    }
  if$
}


FUNCTION {check.mrnumber}
{mrnumber 't :=
  ""
    { t empty$ not }
    { t #1 #2 substring$ "\#" =
			{ t #1 #2 substring$ *
	 			 t #2 global.max$ substring$ 't :=
			}
			{
			  t #1 #1 substring$ "#" =
					{ "\#" *
		 					 t #2 global.max$ substring$ 't :=
					}
				{ t #1 #1 substring$ *
	 			 t #2 global.max$ substring$ 't :=
				}
     	 if$
      }
      if$
    }
  while$
}

FUNCTION {format.mrnumber}
{ mrnumber empty$
    { "" }
    {	bother "other" =
		     {check.mrnumber}
		     {"\mathreviewsnumber{" check.mrnumber * "}" * }
			if$
    }
  if$
}


INTEGERS { nameptr namesleft numnames }

FUNCTION {format.names}
{ 's :=
  #1 'nameptr :=
  s num.names$ 'numnames :=
  numnames 'namesleft :=
    { namesleft #0 > }
%
%    The next line was changed by NMD in Dec 97 from
%
%    { s nameptr "{ff~}{vv~}{ll}{, jj}" format.name$ 't :=
%
%   so that first names will be abbreviated.  Line copied
%   from abbrv.bst
%
	{ s nameptr "{f.~}{vv~}{ll}{, jj}" format.name$ 't :=
      nameptr #1 >
	{ namesleft #1 >
	    { ", " * t * }
	    { numnames #2 >
		{ "," * }
		'skip$
	      if$
	      t "others" =
		{ " et~al." * }
		{ " and " * t * }
	      if$
	    }
	  if$
	}
	't
      if$
      nameptr #1 + 'nameptr :=
      namesleft #1 - 'namesleft :=
    }
  while$
}

FUNCTION {format.authors}
{ author empty$
    { "" }
    { author format.names }
  if$
}

FUNCTION {format.editors}
{ editor empty$
    { "" }
    { editor format.names
      editor num.names$ #1 >
	{ ", editors" * }
	{ ", editor" * }
      if$
    }
  if$
}

%  Do not decapitalize title
FUNCTION {format.title}
{ title empty$
    { "" }
    { "{" title * "}" * }
  if$
}

FUNCTION {n.dashify}
{ 't :=
  ""
    { t empty$ not }
    { t #1 #1 substring$ "-" =
	{ t #1 #2 substring$ "--" = not
	    { "--" *
	      t #2 global.max$ substring$ 't :=
	    }
	    {   { t #1 #1 substring$ "-" = }
		{ "-" *
		  t #2 global.max$ substring$ 't :=
		}
	      while$
	    }
	  if$
	}
	{ t #1 #1 substring$ *
	  t #2 global.max$ substring$ 't :=
	}
      if$
    }
  while$
}

FUNCTION {format.date}
{ year empty$
    { month empty$
	{ "" }
	{ "there's a month but no year in " cite$ * warning$
	  month
	}
      if$
    }
    { month empty$
	'year
	{ month " " * year * }
      if$
    }
  if$
}

FUNCTION {format.btitle}
{ title emphasize
}

FUNCTION {tie.or.space.connect}
{ duplicate$ text.length$ #3 <
    { "~" }
    { " " }
  if$
  swap$ * *
}

FUNCTION {either.or.check}
{ empty$
    'pop$
    { "can't use both " swap$ * " fields in " * cite$ * warning$ }
  if$
}

FUNCTION {format.bvolume}
{ volume empty$
    { "" }
    { "volume" volume tie.or.space.connect
      series empty$
	'skip$
	{ " of " * series emphasize * }
      if$
      "volume and number" number either.or.check
    }
  if$
}

FUNCTION {format.number.series}
{ volume empty$
    { number empty$
	{ series field.or.null }
	{ output.state mid.sentence =
	    { "number" }
	    { "Number" }
	  if$
	  number tie.or.space.connect
	  series empty$
	    { "there's a number but no series in " cite$ * warning$ }
	    { " in " * series * }
	  if$
	}
      if$
    }
    { "" }
  if$
}

FUNCTION {format.edition}
{ edition empty$
    { "" }
    { output.state mid.sentence =
	{ edition "l" change.case$ " edition" * }
	{ edition "t" change.case$ " edition" * }
      if$
    }
  if$
}

INTEGERS { multiresult }

FUNCTION {multi.page.check}
{ 't :=
  #0 'multiresult :=
    { multiresult not
      t empty$ not
      and
    }
    { t #1 #1 substring$
      duplicate$ "-" =
      swap$ duplicate$ "," =
      swap$ "+" =
      or or
	{ #1 'multiresult := }
	{ t #2 global.max$ substring$ 't := }
      if$
    }
  while$
  multiresult
}

FUNCTION {format.pages}
{ pages empty$
    { "" }
    { pages multi.page.check
	{ "pages" pages n.dashify tie.or.space.connect }
	{ "page" pages tie.or.space.connect }
      if$
    }
  if$
}

FUNCTION {format.vol.num.pages}
{ volume field.or.null
  number empty$
    'skip$
    { "(" number * ")" * *
      volume empty$
	{ "there's a number but no volume in " cite$ * warning$ }
	'skip$
      if$
    }
  if$
  pages empty$
    'skip$
    { duplicate$ empty$
	{ pop$ format.pages }
	{ ":" * pages n.dashify * }
      if$
    }
  if$
}

%  Format bold vol (year), pages.
FUNCTION {format.vol.year.pages}
{ volume field.or.null bold
  year empty$
    'skip$
% Next lines chanver v1.2 from
%    { "(" format.date * ")" * *
%      volume empty$
%        { "there's a year but no volume in " cite$ * warning$ }
%        'skip$
%      if$
%   }
    { volume empty$
        { "there's a year but no volume in " cite$ * warning$
          "(" } % no leading space if no vol
        { " (" } % yes if there is
      if$
      format.date * ")" * *
    }
  if$
  pages empty$
    'skip$
    { duplicate$ empty$
	{ pop$ format.pages }
	{ ", " * pages n.dashify * }
      if$
    }
  if$
}

FUNCTION {format.chapter.pages}
{ chapter empty$
    'format.pages
    { type empty$
	{ "chapter" }
	{ type "l" change.case$ }
      if$
      chapter tie.or.space.connect
      pages empty$
	'skip$
	{ ", " * format.pages * }
      if$
    }
  if$
}

FUNCTION {format.in.ed.booktitle}
{ booktitle empty$
    { "" }
    { editor empty$
	{ "In " booktitle emphasize * }
	{ "In " format.editors * ", " * booktitle emphasize * }
      if$
    }
  if$
}

FUNCTION {empty.misc.check}
{ author empty$ title empty$ howpublished empty$
  month empty$ year empty$ note empty$
  and and and and and
  key empty$ not and
    { "all relevant fields are empty in " cite$ * warning$ }
    'skip$
  if$
}

FUNCTION {format.thesis.type}
{ type empty$
    'skip$
    { pop$
      type "t" change.case$
    }
  if$
}

FUNCTION {format.tr.number}
{ type empty$
    { "Technical Report" }
    'type
  if$
  number empty$
    { "t" change.case$ }
    { number tie.or.space.connect }
  if$
}

FUNCTION {format.article.crossref}
{ key empty$
    { journal empty$
	{ "need key or journal for " cite$ * " to crossref " * crossref *
	  warning$
	  ""
	}
	{ "In {\em " journal * "\/}" * }
      if$
    }
    { "In " key * }
  if$
  " \cite{" * crossref * "}" *
}

FUNCTION {format.crossref.editor}
{ editor #1 "{vv~}{ll}" format.name$
  editor num.names$ duplicate$
  #2 >
    { pop$ " et~al." * }
    { #2 <
	'skip$
	{ editor #2 "{ff }{vv }{ll}{ jj}" format.name$ "others" =
	    { " et~al." * }
	    { " and " * editor #2 "{vv~}{ll}" format.name$ * }
	  if$
	}
      if$
    }
  if$
}

FUNCTION {format.book.crossref}
{ volume empty$
    { "empty volume in " cite$ * "'s crossref of " * crossref * warning$
      "In "
    }
    { "Volume" volume tie.or.space.connect
      " of " *
    }
  if$
  editor empty$
  editor field.or.null author field.or.null =
  or
    { key empty$
	{ series empty$
	    { "need editor, key, or series for " cite$ * " to crossref " *
	      crossref * warning$
	      "" *
	    }
	    { "{\em " * series * "\/}" * }
	  if$
	}
	{ key * }
      if$
    }
    { format.crossref.editor * }
  if$
  " \cite{" * crossref * "}" *
}

FUNCTION {format.incoll.inproc.crossref}
{ editor empty$
  editor field.or.null author field.or.null =
  or
    { key empty$
	{ booktitle empty$
	    { "need editor, key, or booktitle for " cite$ * " to crossref " *
	      crossref * warning$
	      ""
	    }
	    { "In {\em " booktitle * "\/}" * }
	  if$
	}
	{ "In " key * }
      if$
    }
    { "In " format.crossref.editor * }
  if$
  " \cite{" * crossref * "}" *
}

% New version of article
FUNCTION {article}
{ output.bibitem
  format.authors "author" output.check
  new.block
  format.title add.hiddenurl "title" output.check
  new.block
  crossref missing$
    { journal emphasize "journal" output.check
      format.vol.year.pages output.nocomma
    }
    { format.article.crossref output.nonnull
      format.pages output
    }
  if$
  new.block
  note output
  new.block url output.url
  format.eprint output
  format.mrnumber output
  fin.entry
}

FUNCTION {book}
{ output.bibitem
  author empty$
    { format.editors "author and editor" output.check }
    { format.authors output.nonnull
      crossref missing$
	{ "author and editor" editor either.or.check }
	'skip$
      if$
    }
  if$
  new.block
  format.btitle add.hiddenurl "title" output.check
  crossref missing$
    { format.bvolume output
      new.block
      format.number.series output
      new.sentence
      publisher "publisher" output.check
      address output
    }
    { new.block
      format.book.crossref output.nonnull
    }
  if$
  format.edition output
  format.date "year" output.check
  new.block
  note output
  new.block url output.url
  format.eprint output
  format.mrnumber output
  fin.entry
}

FUNCTION {booklet}
{ output.bibitem
  format.authors output
  new.block
  format.title add.hiddenurl "title" output.check
  howpublished address new.block.checkb
  howpublished output
  address output
  format.date output
  new.block
  note output
  new.block url output.url
  format.eprint output
  format.mrnumber output
  fin.entry
}

FUNCTION {inbook}
{ output.bibitem
  author empty$
    { format.editors "author and editor" output.check }
    { format.authors output.nonnull
      crossref missing$
	{ "author and editor" editor either.or.check }
	'skip$
      if$
    }
  if$
  new.block
  format.btitle add.hiddenurl "title" output.check
  crossref missing$
    { format.bvolume output
      format.chapter.pages "chapter and pages" output.check
      new.block
      format.number.series output
      new.sentence
      publisher "publisher" output.check
      address output
    }
    { format.chapter.pages "chapter and pages" output.check
      new.block
      format.book.crossref output.nonnull
    }
  if$
  format.edition output
  format.date "year" output.check
  new.block
  note output
  new.block url output.url
  format.eprint output
  format.mrnumber output
  fin.entry
}

FUNCTION {incollection}
{ output.bibitem
  format.authors "author" output.check
  new.block
  format.title add.hiddenurl "title" output.check
  new.block
  crossref missing$
    { format.in.ed.booktitle "booktitle" output.check
      format.bvolume output
      format.number.series output
      format.chapter.pages output
      new.sentence
      publisher "publisher" output.check
      address output
      format.edition output
      format.date "year" output.check
    }
    { format.incoll.inproc.crossref output.nonnull
      format.chapter.pages output
    }
  if$
  new.block
  note output
  new.block url output.url
  format.eprint output
  format.mrnumber output
  fin.entry
}

FUNCTION {inproceedings}
{ output.bibitem
  format.authors "author" output.check
  new.block
  format.title add.hiddenurl "title" output.check
  new.block
  crossref missing$
    { format.in.ed.booktitle "booktitle" output.check
      format.bvolume output
      format.number.series output
      format.pages output
      address empty$
	{ organization publisher new.sentence.checkb
	  organization output
	  publisher output
	  format.date "year" output.check
	}
	{ address output.nonnull
	  format.date "year" output.check
	  new.sentence
	  organization output
	  publisher output
	}
      if$
    }
    { format.incoll.inproc.crossref output.nonnull
      format.pages output
    }
  if$
  new.block
  note output
  new.block url output.url
  format.eprint output
  format.mrnumber output
  fin.entry
}

FUNCTION {conference} { inproceedings }

FUNCTION {manual}
{ output.bibitem
  author empty$
    { organization empty$
	'skip$
	{ organization output.nonnull
	  address output
	}
      if$
    }
    { format.authors output.nonnull }
  if$
  new.block
  format.btitle add.hiddenurl "title" output.check
  author empty$
    { organization empty$
	{ address new.block.checka
	  address output
	}
	'skip$
      if$
    }
    { organization address new.block.checkb
      organization output
      address output
    }
  if$
  format.edition output
  format.date output
  new.block
  note output
  new.block url output.url
  format.eprint output
  fin.entry
}

FUNCTION {mastersthesis}
{ output.bibitem
  format.authors "author" output.check
  new.block
  format.title add.hiddenurl "title" output.check
  new.block
  "Master's thesis" format.thesis.type output.nonnull
  school "school" output.check
  address output
  format.date "year" output.check
  new.block
  note output
  new.block url output.url
  format.eprint output
  format.mrnumber output
  fin.entry
}

FUNCTION {misc}
{ output.bibitem
  format.authors output
  title howpublished new.block.checkb
  format.title add.hiddenurl output
  howpublished new.block.checka
  howpublished output
  format.date output
  new.block
  note output
  new.block url output.url
  format.eprint output
  format.mrnumber output
  fin.entry
  empty.misc.check
}

FUNCTION {phdthesis}
{ output.bibitem
  format.authors "author" output.check
  new.block
  format.btitle add.hiddenurl "title" output.check
  new.block
  "PhD thesis" format.thesis.type output.nonnull
  school "school" output.check
  address output
  format.date "year" output.check
  new.block
  note output
  new.block url output.url
  format.eprint output
  format.mrnumber output
  fin.entry
}

FUNCTION {proceedings}
{ output.bibitem
  editor empty$
    { organization output }
    { format.editors output.nonnull }
  if$
  new.block
  format.btitle add.hiddenurl "title" output.check
  format.bvolume output
  format.number.series output
  address empty$
    { editor empty$
	{ publisher new.sentence.checka }
	{ organization publisher new.sentence.checkb
	  organization output
	}
      if$
      publisher output
      format.date "year" output.check
    }
    { address output.nonnull
      format.date "year" output.check
      new.sentence
      editor empty$
	'skip$
	{ organization output }
      if$
      publisher output
    }
  if$
  new.block
  note output
  new.block url output.url
  format.eprint output
  format.mrnumber output
  fin.entry
}

FUNCTION {techreport}
{ output.bibitem
  format.authors "author" output.check
  new.block
  format.title add.hiddenurl "title" output.check
  new.block
  format.tr.number output.nonnull
  institution "institution" output.check
  address output
  format.date "year" output.check
  new.block
  note output
  new.block url output.url
  format.eprint output
  format.mrnumber output
  fin.entry
}

FUNCTION {unpublished}
{ output.bibitem
  format.authors "author" output.check
  new.block
  format.title add.hiddenurl "title" output.check
  new.block
  note "note" output.check
  format.date output
  new.block url output.url
  format.eprint output
  format.mrnumber output
  fin.entry
}

FUNCTION {default.type} { misc }

MACRO {jan} {"January"}

MACRO {feb} {"February"}

MACRO {mar} {"March"}

MACRO {apr} {"April"}

MACRO {may} {"May"}

MACRO {jun} {"June"}

MACRO {jul} {"July"}

MACRO {aug} {"August"}

MACRO {sep} {"September"}

MACRO {oct} {"October"}

MACRO {nov} {"November"}

MACRO {dec} {"December"}

% Commented out v1.2. Not needed for math
%MACRO {acmcs} {"ACM Computing Surveys"}

%MACRO {acta} {"Acta Informatica"}

%MACRO {cacm} {"Communications of the ACM"}

%MACRO {ibmjrd} {"IBM Journal of Research and Development"}

%MACRO {ibmsj} {"IBM Systems Journal"}

%MACRO {ieeese} {"IEEE Transactions on Software Engineering"}

%MACRO {ieeetc} {"IEEE Transactions on Computers"}

%MACRO {ieeetcad}
% {"IEEE Transactions on Computer-Aided Design of Integrated Circuits"}

%MACRO {ipl} {"Information Processing Letters"}

%MACRO {jacm} {"Journal of the ACM"}

%MACRO {jcss} {"Journal of Computer and System Sciences"}

%MACRO {scp} {"Science of Computer Programming"}

%MACRO {sicomp} {"SIAM Journal on Computing"}

%MACRO {tocs} {"ACM Transactions on Computer Systems"}

%MACRO {tods} {"ACM Transactions on Database Systems"}

%MACRO {tog} {"ACM Transactions on Graphics"}

%MACRO {toms} {"ACM Transactions on Mathematical Software"}

%MACRO {toois} {"ACM Transactions on Office Information Systems"}

%MACRO {toplas} {"ACM Transactions on Programming Languages and Systems"}

%MACRO {tcs} {"Theoretical Computer Science"}

READ

EXECUTE{print.ver}  % Added Pergler 1.2


FUNCTION {sortify}
{ purify$
  "l" change.case$
}

INTEGERS { len }

FUNCTION {chop.word}
{ 's :=
  'len :=
  s #1 len substring$ =
    { s len #1 + global.max$ substring$ }
    's
  if$
}

INTEGERS { et.al.char.used }

FUNCTION {initialize.et.al.char.used}
{ #0 'et.al.char.used :=
}

EXECUTE {initialize.et.al.char.used}

FUNCTION {format.lab.names}
{ 's :=
  s num.names$ 'numnames :=
  numnames #1 >
    { numnames #5 >
	{ #4 'namesleft := }
	{ numnames 'namesleft := }
      if$
      #1 'nameptr :=
      ""
	{ namesleft #0 > }
	{ nameptr numnames =
	    { s nameptr "{ff }{vv }{ll}{ jj}" format.name$ "others" =
		{ "{\etalchar{+}}" *
		  #1 'et.al.char.used :=
		}
		{ s nameptr "{v{}}{l{}}" format.name$ * }
	      if$
	    }
	    { s nameptr "{v{}}{l{}}" format.name$ * }
	  if$
	  nameptr #1 + 'nameptr :=
	  namesleft #1 - 'namesleft :=
	}
      while$
      numnames #5 >
	{ "{\etalchar{+}}" *
	  #1 'et.al.char.used :=
	}
	'skip$
      if$
    }
    { s #1 "{v{}}{l{}}" format.name$
      duplicate$ text.length$ #2 <
	{ pop$ s #1 "{ll}" format.name$ #3 text.prefix$ }
	'skip$
      if$
    }
  if$
}

FUNCTION {author.key.label}
{ author empty$
    { key empty$
	{ cite$ #1 #3 substring$ }
	{ key }
      if$
    }
    { author format.lab.names }
  if$
}

%  Use key with first priority.
FUNCTION {key.author.label}
{ key empty$
    { author empty$
	{ cite$ #1 #3 substring$ }
    	{ author format.lab.names }
      if$
    }
    { key }
  if$
}

FUNCTION {author.editor.key.label}
{ author empty$
    { editor empty$
	{ key empty$
	    { cite$ #1 #3 substring$ }
	    { key }
	  if$
	}
	{ editor format.lab.names }
      if$
    }
    { author format.lab.names }
  if$
}

% Key first
FUNCTION {key.author.editor.label}
{ key empty$
    { author empty$
        { editor empty$
	    { cite$ #1 #3 substring$ }
	{ editor format.lab.names }
	  if$
	}
    { author format.lab.names }
      if$
    }
    { key }
  if$
}

FUNCTION {author.key.organization.label}
{ author empty$
    { key empty$
	{ organization empty$
	    { cite$ #1 #3 substring$ }
	    { "The " #4 organization chop.word #3 text.prefix$ }
	  if$
	}
	{ key }
      if$
    }
    { author format.lab.names }
  if$
}

%Key first
FUNCTION {key.author.organization.label}
{ key empty$
    { author empty$
	{ organization empty$
	    { cite$ #1 #3 substring$ }
	    { "The " #4 organization chop.word #3 text.prefix$ }
	  if$
	}
        { author format.lab.names }
      if$
    }
    { key }
  if$
}

FUNCTION {editor.key.organization.label}
{ editor empty$
    { key empty$
	{ organization empty$
	    { cite$ #1 #3 substring$ }
	    { "The " #4 organization chop.word #3 text.prefix$ }
	  if$
	}
	{ key }
      if$
    }
    { editor format.lab.names }
  if$
}

%Key first
FUNCTION {key.editor.organization.label}
{ key empty$
   { editor empty$
	{ organization empty$
	    { cite$ #1 #3 substring$ }
	    { "The " #4 organization chop.word #3 text.prefix$ }
	  if$
	}
        { editor format.lab.names }
      if$
    }
    { key }
  if$
}

% Use keys with first priority
% Purify rather than sortify labels, so AB and Ab are distinct.
FUNCTION {calc.label}
{ type$ "book" =
  type$ "inbook" =
  or
    'key.author.editor.label
    { type$ "proceedings" =
	'key.editor.organization.label
	{ type$ "manual" =
	    'key.author.organization.label
	    'key.author.label
	  if$
	}
      if$
    }
  if$
  duplicate$
  'label :=
  'sort.label :=
}

FUNCTION {sort.format.names}
{ 's :=
  #1 'nameptr :=
  ""
  s num.names$ 'numnames :=
  numnames 'namesleft :=
    { namesleft #0 > }
    { nameptr #1 >
	{ "   " * }
	'skip$
      if$
      s nameptr "{vv{ } }{ll{ }}{  ff{ }}{  jj{ }}" format.name$ 't :=
      nameptr numnames = t "others" = and
	{ "et al" * }
	{ t sortify * }
      if$
      nameptr #1 + 'nameptr :=
      namesleft #1 - 'namesleft :=
    }
  while$
}

FUNCTION {sort.format.title}
{ 't :=
  "A " #2
    "An " #3
      "The " #4 t chop.word
    chop.word
  chop.word
  sortify
  #1 global.max$ substring$
}

FUNCTION {author.sort}
{ author empty$
    { key empty$
	{ "to sort, need author or key in " cite$ * warning$
	  ""
	}
	{ key sortify }
      if$
    }
    { author sort.format.names }
  if$
}

FUNCTION {author.editor.sort}
{ author empty$
    { editor empty$
	{ key empty$
	    { "to sort, need author, editor, or key in " cite$ * warning$
	      ""
	    }
	    { key sortify }
	  if$
	}
	{ editor sort.format.names }
      if$
    }
    { author sort.format.names }
  if$
}

FUNCTION {author.organization.sort}
{ author empty$
    { organization empty$
	{ key empty$
	    { "to sort, need author, organization, or key in " cite$ * warning$
	      ""
	    }
	    { key sortify }
	  if$
	}
	{ "The " #4 organization chop.word sortify }
      if$
    }
    { author sort.format.names }
  if$
}

FUNCTION {editor.organization.sort}
{ editor empty$
    { organization empty$
	{ key empty$
	    { "to sort, need editor, organization, or key in " cite$ * warning$
	      ""
	    }
	    { key sortify }
	  if$
	}
	{ "The " #4 organization chop.word sortify }
      if$
    }
    { editor sort.format.names }
  if$
}

% Use late year if empty
FUNCTION {presort}
{ type$ "book" =
  type$ "inbook" =
  or
    'author.editor.sort
    { type$ "proceedings" =
	'editor.organization.sort
	{ type$ "manual" =
	    'author.organization.sort
	    'author.sort
	  if$
	}
      if$
    }
  if$
  "    "
  *
  year field.or.late sortify
  *
  title field.or.null sort.format.title
  *
  #1 entry.max$ substring$
  'sort.key$ :=
  calc.label
}

ITERATE {presort}

SORT

STRINGS { longest.label last.sort.label next.extra }

INTEGERS { longest.label.width last.extra.num }

FUNCTION {initialize.longest.label}
{ "" 'longest.label :=
  #0 int.to.chr$ 'last.sort.label :=
  "" 'next.extra :=
  #0 'longest.label.width :=
  #0 'last.extra.num :=
}

% Use Key1, Key2, ... for extras.
FUNCTION {forward.pass}
{ last.sort.label sort.label =
    { last.extra.num #1 + 'last.extra.num :=
      last.extra.num int.to.str$ 'extra.label :=
    }
    { #1 'last.extra.num :=
      "" 'extra.label :=
      sort.label 'last.sort.label :=
    }
  if$
}

FUNCTION {reverse.pass}
{ next.extra "2" =
    { "1" 'extra.label := }
    'skip$
  if$
  label extra.label * 'label :=
  label width$ longest.label.width >
    { label 'longest.label :=
      label width$ 'longest.label.width :=
    }
    'skip$
  if$
  extra.label 'next.extra :=
}

EXECUTE {initialize.longest.label}

ITERATE {forward.pass}

REVERSE {reverse.pass}

FUNCTION {begin.bib}
{ et.al.char.used
    { "\newcommand{\etalchar}[1]{$^{#1}$}" write$ newline$ }
    'skip$
  if$
  preamble$ empty$
    'skip$
    { preamble$ write$ newline$ }
  if$
  "\begin{thebibliography}{"  longest.label  * "}" * write$ newline$
}

EXECUTE {begin.bib}

EXECUTE {init.state.consts}

ITERATE {call.type$}

FUNCTION {end.bib}
{ newline$
  "\end{thebibliography}" write$ newline$
}

EXECUTE {end.bib}
