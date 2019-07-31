(TeX-add-style-hook
 "system"
 (lambda ()
   (TeX-add-to-alist 'LaTeX-provided-class-options
                     '(("article" "11pt" "a4paper")))
   (TeX-add-to-alist 'LaTeX-provided-package-options
                     '(("ulem" "normalem")))
   (add-to-list 'LaTeX-verbatim-environments-local "lstlisting")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperref")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperimage")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperbaseurl")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "nolinkurl")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "url")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "path")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "lstinline")
   (add-to-list 'LaTeX-verbatim-macros-with-delims-local "path")
   (add-to-list 'LaTeX-verbatim-macros-with-delims-local "lstinline")
   (TeX-run-style-hooks
    "latex2e"
    "article"
    "art11"
    "fontspec"
    "xeCJK"
    "graphicx"
    "xcolor"
    "listings"
    "geometry"
    "verbatim"
    "fixltx2e"
    "longtable"
    "float"
    "wrapfig"
    "rotating"
    "ulem"
    "amsmath"
    "marvosym"
    "wasysym"
    "amssymb"
    "hyperref"
    "parskip"
    "indentfirst")
   (LaTeX-add-labels
    "sec:org9be7c1d"
    "sec:orgeef8154"
    "sec:org6b00d23"
    "sec:orge000d01"
    "sec:org98742d1"
    "sec:orgcf3f043"
    "sec:org7c0a221"
    "sec:orgc55be89"
    "sec:org3a1a3b4"))
 :latex)

