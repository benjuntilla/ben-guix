(define-module (ben-guix emacs-xyz)
  #:use-module (guix packages)
  #:use-module (guix git-download)
  #:use-module (guix build-system emacs)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (gnu packages emacs))

(define-public emacs-dirvish-latest
  (package
    (inherit emacs-dirvish)
    (name "emacs-dirvish-latest")
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
    (home-page "https://github.com/hlissner/dirvish")
    (synopsis "Improved version of the Emacs package Dired (hlissner's fork)")
    (description
     "This is a fork of Dirvish, an improved version of the Emacs inbuilt package Dired.
It not only gives Dired an appealing and highly customizable user interface, but
also comes together with almost all possible parts required for full usability
as a modern file manager.")))
