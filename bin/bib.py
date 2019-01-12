"""
Tools for working with LaTeX bibilographies.

License: GNU General Public License version 2 or later

Author:  Nathan Dunfield (nathan@dunfield.info) 

Credits: Partially based on Tolusis and Pitman's:

  http://www.e-publications.org/ims/support/download/getmref.py

"""


import os, sys, re, glob, urllib, time, string, tempfile
import xml.dom.minidom as dom
import xml.parsers.expat as par

# Querying AMS MRef for getting the canonical BibTeX references

mref_querystring = r'''<?xml version = "1.0" encoding = "UTF-8"?>
<mref_batch>
<mref_item outtype="bibtex">
1<inref>
%s
</inref>
<myid>%s</myid>
</mref_item>
</mref_batch>'''

def escapetex(instr):
    res = reduce(lambda a,b: string.replace(a, b[0], b[1]), (instr, ("\\&", '&amp;'), ("<", '&lt;'), (">", '&gt;')))
    return res

def xml_get_item(doc, item):
    return doc.getElementsByTagName(item)[0].firstChild.nodeValue

dom.Document.__getitem__ = xml_get_item

def query_mref(instring, bibID = None, address = 'http://www.ams.org/batchmref'):
    query = mref_querystring % (escapetex(instring), bibID)
    dom.parseString(query)   # sanity check, may throw an exception. 
    url = urllib.urlopen(address, urllib.urlencode({'qdata':query}))
    mref = dom.parseString(url.read())
    if len(mref.getElementsByTagName('batch_error')) > 0:
        raise RuntimeError, "MRef query error"
    m = int(mref['matches'])
    if m != 1: 
        raise IndexError, "got %d matches to query" % m
    ans = mref['outref'].strip()
    ans = ans.replace("URL", "HIDDENURL")
    ans = ans.replace("(electronic)", "")
    if bibID:
        ans = re.sub('(@[a-zA-Z]*\s*{)(MR.*),', '\g<1>%s,' % bibID, ans)
    return ans

def query_mr(instring, address = 'http://www.ams.org/mathscinet-getitem'):
    if instring[:2] == "MR":
        instring = instring[2:]
    url = urllib.urlopen(address + "?mr=" + instring + "&return=bibtex")
    try:
        ans = re.search("<pre>\s*(@.*)</pre>", url.read(), re.DOTALL).group(1).strip()
        ans = ans.replace("URL", "HIDDENURL")
        ans = ans.replace("(electronic)", "")
    except:
        ans = None
    return ans

def query_arXiv(names, title):
    url = "http://arxiv.org/find/grp_math/1/AND" + (len(names) - 1)*"+AND"
    for n in names:
        url += "+au:+" + n
    url += "+ti:+EXACT+" + title.replace(" ", "_")
    url += "/0/1/0/all/0/1"
    data =  urllib.urlopen(url).read()
    if re.search("No matches were found for your search", data):
        return []
    if re.search("Search error", data):
        print "Error in arXiv search string for %s and %s" % names, title
        return []
    return re.findall('<a href="/abs/(.*?)" title="Abstract">arXiv', data)

def find_metas(metas, name):
    return [m.getAttribute('content') for m in metas if m.getAttribute('name') == name]

def find_meta(metas, name):
    return find_metas(metas, name)[0]


def de_TeX(str):
    ans = re.sub(r"(\\.)|\$|\{|\}", "", str)
    return re.sub("\s+", " ", ans, re.DOTALL).strip()
  
                  
def parse_bbl_string(item):
    names, title = item.split("{\\em")
    names = re.sub("[A-Z]\.", "", names)
    title = de_TeX(title.split("}")[0])
    names = [de_TeX(n) for n in  names.replace("and", ",").split(",") if len(n.strip()) > 0]
    return names, title


def determine_arXiv_paper_length(url):
    pdf_file_name = tempfile.mktemp() + ".pdf"
    open(pdf_file_name, 'w').write(urllib.urlopen(url).read())
    found = False
    for command in ['pdfinfo', 'xpdf-pdfinfo']:
        if os.system('which ' + command  + " 2>&1") == 0:
            pdf_info = os.popen(command + ' ' + pdf_file_name + " 2>&1").read()
            found = True
    os.remove(pdf_file_name)
    if found:
        return int(re.search("Pages:\s*(\d+)", pdf_info).group(1))
    else:
        print('Xpdf not found in path')
        sys.exit()

def make_arXiv_entry(query, cite_name = None):
    # Get data from arXiv.  In 2013/10 the xml started being misformed, so we
    # cut of the top of the document where the actual data is.  
    url = query if re.match("https{0,1}://", query) else "http://arxiv.org/abs/" + query
    arXiv_data = urllib.urlopen(url).read()
    pos = arXiv_data.find('</head>')
    arXiv_data = arXiv_data[ : pos + 7] + '</html>'
    # In 2019/1, started have improperly escaped "&" symbols in some urls
    arXiv_data = arXiv_data.replace('&', '')
    
    metas = dom.parseString(arXiv_data).getElementsByTagName('meta')
    pages = determine_arXiv_paper_length(find_meta(metas, 'citation_pdf_url'))
    year = find_meta(metas, 'citation_online_date').split("/")[0]
    if cite_name == None:
        cite_name = ''.join( [name.split(',')[0] for name in find_metas(metas, 'citation_author')] ) + year
    
    ans = "@misc{ %s,\n" % cite_name
    ans += "    AUTHOR = {" + " and ".join(find_metas(metas, 'citation_author')) + "},\n"
    ans += "    TITLE  = {" + find_meta(metas, 'citation_title') + "},\n"
    ans += "    NOTE   = {Preprint " + year + ", %d pages},\n" % pages
    ans += "    EPRINT = {arXiv:" + find_meta(metas, 'citation_arxiv_id') + "},\n}\n"
    return ans

def parse_bbl(filename):
    bib = re.search(r'\\begin\s*\{thebibliography\}(.*)\end\s*\{thebibliography\}',
                    open(filename).read(), re.DOTALL).group(1)
    bib = bib.replace('\\bibitem', '\n\n\\bibitem') + "\n\n"
    return [ b[1:3] for b in  re.findall(r'\\bibitem\s*(\[.*?\])*?\s?\{(.*?)\}(.*?)\n\n', bib, re.DOTALL)]

def convert_bbl_to_bibtex(infile, outfile):
    out = open(outfile, "w")
    for name, cite in parse_bbl(infile):
        bib = name + "\n" + cite
        try:
            bib = query_mref(cite, name)
        except:
            try:
                matches = query_arXiv(* parse_bbl_string(cite) )
                if len(matches) == 1:
                    bib = make_arXiv_entry(matches[0], name)
            except:
                pass

        out.write(bib + "\n\n")
        out.flush()


def get_bibtex_field(bibtex, field_name):
    m = re.search("[\n\t ,]+" + field_name + "\s*=\s*\{(.*?)\},", bibtex, re.IGNORECASE | re.DOTALL)
    return m.group(1).strip() if m else None

def get_bibtex_authors(bibtex):
    authors = []
    for author in get_bibtex_field(bibtex, 'author').split(" and "):
        author = author.strip()
        if re.search(",", author):
            authors.append( author.split(',')[0].strip() )
        else:
            authors.append( author.split(' ')[-1].strip() )

    return [de_TeX(a) for a in authors]

          
def add_eprints_to_bibtex_entry(bibitem):
    out = ''
    for bib in re.findall('@[a-zA-Z]*\s*\{.*?\n\}', bibitem, re.DOTALL):
        if not ( re.match('@preamble', bib) != None or  get_bibtex_field(bib, 'eprint') ):
            year = get_bibtex_field(bib, 'year')
            if year and int(year) > 1995:
                ans = query_arXiv(get_bibtex_authors(bib), de_TeX(get_bibtex_field(bib, 'title')))
                if len(ans) == 1:
                    bib = bib.strip()[:-1] + "    EPRINT = {arXiv:" + ans[0] + "},\n}\n"

        out += bib

    return out

def load_bib_file(infile):
    bibs = re.findall('@[a-zA-Z]*\s*\{.*?\n\}\n', open(infile).read(), re.DOTALL)
    return [bib for bib in bibs if re.match('@preamble', bib) == None]

def add_eprints_to_bibtex(infile, outfile):
    out = open(outfile, "w")
    for bib in re.findall('@[a-zA-Z]*\s*\{.*?\n\}\n', open(infile).read() + "\n", re.DOTALL):
        if not ( re.match('@preamble', bib) != None or  get_bibtex_field(bib, 'eprint') ):
            year = get_bibtex_field(bib, 'year')
            if year and int(year) > 1995:
                ans = query_arXiv(get_bibtex_authors(bib), de_TeX(get_bibtex_field(bib, 'title')))
                if len(ans) == 1:
                    bib = bib.strip()[:-1] + "    EPRINT = {arXiv:" + ans[0] + "},\n}\n"
                    print "added"

        out.write(bib + "\n")
                

#ans = convert_bbl_to_bibtex("/Users/dunfield/a/Paper/ahyp_knot_030811.tex", "/Users/dunfield/a/Paper/ahyp_knot.bib")

# ans = add_eprints_to_bibtex("/Users/dunfield/a/Paper/ahyp_knot.bib", "/Users/dunfield/a/Paper/ahyp_knot.bib-new")

# ans = make_arXiv_entry("http://arxiv.org/abs/1012.3030")

#ans = query_mr("1965363")
