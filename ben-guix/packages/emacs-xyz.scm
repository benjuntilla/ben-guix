(define-module (ben-guix packages emacs-xyz)
  #:use-module (guix gexp)
  #:use-module (guix packages)
  #:use-module (guix git-download)
  #:use-module (guix build-system emacs)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (gnu packages emacs-xyz)
  #:use-module (gnu packages emacs))

(define-public emacs-dirvish-hlissner
  (package
    (name "emacs-dirvish-hlissner")
    (version "2.0.53")
    (source (origin
              (method git-fetch)
              (uri (git-reference
                    (url "https://github.com/hlissner/dirvish")
                    (commit "5f046190e886fb0a2dae7e884cc7cd9bcf48ac26")))
              (sha256
               (base32
                "0vpmx982anb7gbfqiq5ccfnqxi653m44yr0pq1awag71xf2xn92l"))
              (file-name (git-file-name name version))))
    (build-system emacs-build-system)
    (arguments
     (list
      #:phases
      #~(modify-phases %standard-phases
          ;; Move the extensions source files to the top level, which
          ;; is included in the EMACSLOADPATH.
          (add-after 'unpack 'move-source-files
            (lambda _
              (let ((el-files (find-files "./extensions" ".*\\.el$")))
                (for-each (lambda (f)
                            (rename-file f (basename f)))
                          el-files)))))))
    (home-page "https://github.com/hlissner/dirvish")
    (synopsis "Improved version of the Emacs package Dired")
    (description
     "Dirvish is an improved version of the Emacs inbuilt package Dired.  It
not only gives Dired an appealing and highly customizable user interface, but
also comes together with almost all possible parts required for full usability
as a modern file manager.")
    (license license:gpl3+)))

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

(define-public emacs-aidermacs
  (package
    (name "emacs-aidermacs")
    (version "20250329.444")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/MatthewZMD/aidermacs.git")
             (commit "a252760d74a06c4287244ac9d5f4fb19ef2e33fb")))
       (file-name (git-file-name name version))
       (sha256
        (base32 "17l53phblh4k6w14vr9ljbbwj8kdaab4cpv85slf7m03fq5yash0"))))
    (build-system emacs-build-system)
    (propagated-inputs (list emacs-transient emacs-compat))
    (home-page "https://github.com/MatthewZMD/aidermacs")
    (synopsis "AI pair programming with Aider")
    (description
     "Aidermacs integrates with Aider (https://aider.chat/) for AI-assisted code
modification in Emacs.  Aider lets you pair program with LLMs to edit code in
your local git repository.  It works with both new projects and existing code
bases, supporting Claude, @code{DeepSeek}, @code{ChatGPT}, and can connect to
almost any LLM including local models.  Think of it as having a helpful coding
partner that can understand your code, suggest improvements, fix bugs, and even
write new code for you.  Whether you're working on a new feature, debugging, or
just need help understanding some code, Aidermacs provides an intuitive way to
collaborate with AI while staying in your familiar Emacs environment.
Originally forked from Kang Tu <tninja@@gmail.com>'s Aider.el.")
    (license #f)))
