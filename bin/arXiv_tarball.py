#! /usr/bin/env python2.7

description="""\
Make a tarbar suitable for uploading to the arXiv.
"""

import os, sys, re, glob, argparse

TeXLive_prefix = "/usr/local/texlive"
skips = ["/Users/dunfield/tex/inputs/user-is-nathan-dunfield.tex"]

def parse_tex_output(base_name, include_all=False):
    data = open(base_name + ".log").read()

    # First find all the included packages, excluding the
    # ones that live in TeXLive

    includes = []
    for extention in ["tex", "cls", "sty", "bbl", "toc"]:
        poss_includes = re.findall( "\s\((\S+\." + extention + ")", data)
        includes += [p for p in poss_includes
                     if not (re.search(TeXLive_prefix, p) or p in skips)]

    # add ancillary files
    includes += glob.glob("anc/*")

    if include_all:
        includes += glob.glob("*.bib")
        includes += glob.glob("*.bst")
    
    # add image files 
    images = re.findall( "<use (\S+)>", data)
    if include_all:
        poss_eps = [os.path.splitext(im)[0] + ".eps" for im in images]
        images = list( set(images).union(set([im for im in poss_eps if os.path.exists(im)])) )

    return includes + images


def is_local(file_name):
    return os.path.exists("./" + file_name)

def is_nmd(file_name):
    return file_name.find('/nmd/') >= 0

def create_needed_directories(files, dest_dir):
    """
    We assume that any files contained in directories
    under the current one should be put into the arXiv
    in the same way.  Files elsewhere will just be put into
    the root directory.  The exception is the nmd package.
    """
    dirs = set([ os.path.split(f)[0] for f in files if is_local(f)])
    dirs.discard(''), dirs.discard('.')
    if True in [is_nmd(f) for f in files]:
        dirs.add('nmd')
    for d in sorted(list(dirs)):
        target = dest_dir + "/" + d
        if not os.path.exists(target):
            os.makedirs(target)
    



def main(base_name, include_all=False, extra_includes=None):
    arXiv_dir = "arXiv_" + base_name
    os.system("rm -rf " + arXiv_dir + " " + arXiv_dir + ".tar.gz")
    os.mkdir(arXiv_dir)
    includes = parse_tex_output(base_name, include_all=include_all)
    if not extra_includes is None:
        includes += extra_includes
    for i in includes:
        print(i)
    
    create_needed_directories(includes, arXiv_dir)
    for f in includes:
        if is_local(f):
            target = f
        elif is_nmd(f):
            target = 'nmd/'
        else:
            target = ''
        os.system("cp -RL " + f + " " + arXiv_dir + "/" + target)
    tar_cmd = "tar cfz "
    if sys.platform == 'darwin':
        # turn off special handling of ._* files in tar
        tar_cmd = "COPYFILE_DISABLE=1 " + tar_cmd
    os.system(tar_cmd + arXiv_dir + ".tar.gz " + arXiv_dir)
    os.system("rm -rf " + arXiv_dir)
    
if __name__ == "__main__":
    parser = argparse.ArgumentParser(description=description)
    parser.add_argument('texfile', help='the name of the main tex file')
    parser.add_argument('-a', '--all', action='store_true', help='include eps, bib, and bst files')
    parser.add_argument('-i', '--include', action='append', help='file to include manually')
    args = parser.parse_args()
    base_name = os.path.splitext(args.texfile)[0]
    main(base_name, args.all, args.include)
    
    
