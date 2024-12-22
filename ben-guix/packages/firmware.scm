(define-module (ben-guix packages firmware)
  #:use-module (gnu packages compression)
  #:use-module (gnu packages cpio)
  #:use-module (gnu packages efi)
  #:use-module (gnu packages firmware)
  #:use-module (guix build-system copy)
  #:use-module (guix build-system gnu)
  #:use-module (guix download)
  #:use-module (guix gexp)
  #:use-module (guix git-download)
  #:use-module ((guix licenses) #:prefix guix-license:)
  #:use-module (guix packages)
  #:use-module (guix utils))


(define-public fwupd-nonfree-ben
  (package
    (inherit fwupd)
    (name "fwupd-nonfree-ben")
    (arguments
     (substitute-keyword-arguments (package-arguments fwupd)
       ;; https://issues.guix.gnu.org/60065
       ((#:phases original-phases)
        #~(modify-phases #$original-phases
            (add-before 'configure 'set-polkit-rules-dir
              (lambda _
                (setenv "PKG_CONFIG_POLKIT_GOBJECT_1_ACTIONDIR"
                        (string-append #$output "/share/polkit-1/actions"))))))
       ((#:configure-flags _)
        #~(list "--wrap-mode=nofallback"
                "-Dsystemd=false"
                (string-append "-Defi_os_dir="
                               #$gnu-efi "/lib")
                "-Defi_binary=false"
                (string-append "-Dudevdir="
                               #$output "/lib/udev")
                "--localstatedir=/var"
                (string-append "--libexecdir="
                               #$output "/libexec")
                "-Dsupported_build=true"))))))
