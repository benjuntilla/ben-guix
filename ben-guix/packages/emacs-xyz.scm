(define-module (ben-guix packages emacs-xyz)
  #:use-module (guix gexp)
  #:use-module (guix packages)
  #:use-module (guix git-download)
  #:use-module (guix build-system emacs)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (gnu packages emacs-xyz)
  #:use-module (gnu packages emacs))

(define-public emacs-auctex-latexmk
  (package
    (name "emacs-auctex-latexmk")
    (version "20221025.1219")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/emacsmirror/auctex-latexmk.git")
             (commit "b00a95e6b34c94987fda5a57c20cfe2f064b1c7a")))
       (file-name (git-file-name name version))
       (sha256
        (base32 "0bbvb4aw9frg4fc0z9qkc5xd2s9x65k6vdscy5svsy0h17iacsbb"))))
    (build-system emacs-build-system)
    (propagated-inputs (list emacs-auctex))
    (home-page "https://github.com/emacsmirror/auctex-latexmk")
    (synopsis "Add LatexMk support to AUCTeX")
    (description
     "This library adds @code{LatexMk} support to AUC@code{TeX}.  Requirements: *
AUC@code{TeX} * @code{LatexMk} * @code{TeXLive} (2011 or later if you write
@code{TeX} source in Japanese) To use this package, add the following line to
your .emacs file: (require auctex-latexmk) (auctex-latexmk-setup) And add the
following line to your .latexmkrc file: # .latexmkrc starts $pdf_mode = 1; #
.latexmkrc ends After that, by using M-x @code{TeX-command-master} (or C-c C-c),
you can use @code{LatexMk} command to compile @code{TeX} source.  For Japanese
users: @code{LatexMk} command automatically stores the encoding of a source file
and passes it to latexmk via an environment variable named \"LATEXENC\".  Here is
the example of .latexmkrc to use \"LATEXENC\": # .latexmkrc starts $kanji =
\"-kanji=$ENV{\\\"LATEXENC\\\"}\" if defined $ENV{\"LATEXENC\"}; $latex = \"platex
$kanji\"; $bibtex = \"pbibtex $kanji\"; $dvipdf = dvipdfmx -o %D %S'; $pdf_mode =
3; # .latexmkrc ends.")
    (license #f)))

(define-public emacs-ob-mermaid
  (package
    (name "emacs-ob-mermaid")
    (version "0.0.1") ;; You may want to check for a more specific version
    (source (origin
              (method git-fetch)
              (uri (git-reference
                    (url "https://github.com/arnm/ob-mermaid")
                    (commit "master"))) ;; You might want to use a specific commit hash instead
              (sha256
               (base32
                "1hmpbmwy5cr0p0w89kkfmdip4yh2vps1har5ivh04g83vmhrw18m"))
              (file-name (git-file-name name version))))
    (build-system emacs-build-system)
    (home-page "https://github.com/arnm/ob-mermaid")
    (synopsis "Generate mermaid diagrams using org-mode and org-babel")
    (description
     "This package allows you to generate mermaid diagrams using org-mode,
      org-babel and mermaid-cli. It supports various output formats including
      SVG, PNG and PDF, with customizable properties like width, height, scale,
      theme, and background color.")
    (license license:gpl3+))) ;; You should verify the actual license

