(TeX-add-style-hook
 "pintuan_req"
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
    "sec:orgccf4ee7"
    "sec:orgc51a026"
    "sec:orgb05d3ab"
    "sec:org8bb1897"
    "sec:orgb3efc6f"
    "sec:org798c292"
    "sec:orge48eab0"
    "sec:orge1deb83"
    "sec:orgdad431a"
    "sec:org92e9da5"
    "sec:org888c715"
    "sec:orga515ccf"
    "sec:orgbbc9b2f"
    "sec:org50f784e"
    "sec:org523ec1d"
    "sec:org8c41b6f"
    "sec:orge738206"
    "sec:orgd525a37"
    "sec:org0ba08b8"
    "sec:org899d697"
    "sec:org405fc37"
    "sec:orgd7e73ab"
    "sec:org2ba0067"
    "sec:orgdbcd0e7"
    "sec:orgf92350c"))
 :latex)

