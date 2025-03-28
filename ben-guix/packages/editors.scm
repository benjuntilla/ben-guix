(define-module (ben-guix packages editors)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix git-download)
  #:use-module (guix utils)
  #:use-module (guix upstream)
  #:use-module (guix build utils)
  #:use-module (srfi srfi-1)
  #:use-module (json)
  #:use-module (web client)
  #:use-module (web response)
  #:use-module (ice-9 match)
  #:use-module (nongnu packages editors))

;; Define the updater
(define %vscodium-updater
  (upstream-updater
   (name 'vscodium)
   (description "Updater for VSCodium")
   (pred (lambda (package)
           (string=? (package-name package) "vscodium")))
   (latest
    (lambda* (package #:key (version #f))
      (let* ((url "https://api.github.com/repos/VSCodium/vscodium/releases/latest")
             (response (http-get url #:headers '((user-agent . "Guix"))))
             (json (json-string->scm (response-body-port response))))
        (let ((tag (assoc-ref json "tag_name")))
          (upstream-source
           (package (package-name package))
           (version tag)
           (urls (map (lambda (arch)
                        (string-append
                         "https://github.com/VSCodium/vscodium/releases/download/" tag
                         "/VSCodium-linux-" arch "-" tag ".tar.gz"))
                      '("x64" "arm64" "armhf")))))))))

;; Register the updater
(register-updater %vscodium-updater)

;; Re-export the original vscodium package
(define-public vscodium (@@ (nongnu packages editors) vscodium))
