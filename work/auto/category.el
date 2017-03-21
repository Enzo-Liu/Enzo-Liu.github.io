(TeX-add-style-hook
 "category"
 (lambda ()
   (TeX-add-to-alist 'LaTeX-provided-class-options
                     '(("beamer" "presentation" "bigger")))
   (TeX-add-to-alist 'LaTeX-provided-package-options
                     '(("fontspec" "no-math") ("xeCJK" "BoldFont" "SlantFont" "AutoFakeBold=true" "AutoFakeSlant=true") ("ulem" "normalem")))
   (add-to-list 'LaTeX-verbatim-environments-local "semiverbatim")
   (add-to-list 'LaTeX-verbatim-environments-local "lstlisting")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "path")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "url")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "nolinkurl")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperbaseurl")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperimage")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperref")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "lstinline")
   (add-to-list 'LaTeX-verbatim-macros-with-delims-local "path")
   (add-to-list 'LaTeX-verbatim-macros-with-delims-local "lstinline")
   (TeX-run-style-hooks
    "latex2e"
    "beamer"
    "beamer10"
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
    "hyperref")
   (LaTeX-add-labels
    "sec:org2a13ad8"
    "sec:org43fa7c8"
    "sec:org31909c0"
    "sec:org317ff9c"
    "sec:orgf3b17fe"))
 :latex)

