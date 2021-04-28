Nathan M. Dunfield's personal LaTeX and BibTeX style files
==========================================================

* ``nmd/nmd-article``: A document class which allows one to easily switch between 
  the AMS, Geometry & Topology, and its own custom style (inspired by 
  Hatcher's "Algebraic Topology").  In particular, a document that uses this 
  style can easily be switched over to either  "amsart" or "gtpart" with
  minimal modification.

* ``nmd/nmd-math``: math definitions; collaborators should look here for what's 
  predefined.

* ``nmd/nmd-letter``: University of Illinois letterhead. This uses the old
  "column-I" logo, not the current "block-I" one.

* ``nmd/nmd-hw``: homework.

* ``nmd/nmd-exam``: exam style.  

Usage: Rename this ``latex_class`` directory/folder as ``nmd`` and put
somewhere in your LaTeX search path; the simplest thing is just to put
the ``nmd`` directory in the same location as the TeX file(s) you want
to use it with.

For information about the various options/features of these classes,
see the top of the file ``article.cls``.  Sample documents are in the
``templates`` subdirectory.

The repetitive ``nmd/nmd-blah`` scheme used to be just ``nmd/blah``
but the new form is forced by `recent changes to the LaTeX kernel
<https://tex.stackexchange.com/questions/594853/>`_.


License
=======

Copyright 2009 to present by Nathan M. Dunfield; released under the terms of
the GNU General Public License, version 2 or later. 
