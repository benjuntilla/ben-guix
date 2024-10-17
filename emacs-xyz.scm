(define-module (emacs-xyz)
  #:use-module (guix gexp)
  #:use-module (guix packages)
  #:use-module (guix git-download)
  #:use-module (guix build-system emacs)
  #:use-module ((guix licenses) #:prefix license:)
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
