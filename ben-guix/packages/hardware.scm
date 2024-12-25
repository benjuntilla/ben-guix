(define-module (ben-guix packages hardware)
  #:use-module (guix build-system cargo)
  #:use-module (guix git-download)
  #:use-module (guix build-system meson)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix utils)
  #:use-module (guix build utils)
  #:use-module (guix gexp)
  #:use-module (guix packages)
  #:use-module (gnu packages)
  #:use-module (gnu packages glib)
  #:use-module (gnu packages linux)
  #:use-module (gnu packages pkg-config)
  #:use-module (gnu packages freedesktop))

;; thank you https://codeberg.org/florhizome/guix-local/src/branch/main/guix-local/packages/hardware.scm
(define-public gamemode
  (package
   (name "gamemode")
   (version "1.7")
   (source
    (origin
     (method git-fetch)
     (uri (git-reference
           (url "https://github.com/FeralInteractive/gamemode")
           (commit version)))
     (file-name (git-file-name name version))
     (sha256
      (base32
       "1dbakycp1if1paya0n1kk0cgdacp0a3pjr4djsj978b4c6cmr08c"))))
   (build-system meson-build-system)
   (arguments
    (list #:configure-flags
          #~(list
             (string-append "--libexecdir=" #$output "/libexec")
             "-Dwith-systemd-user-unit-dir=false"
             ;;"-Dwith-systemd-group=false"
             (string-append "-Dwith-dbus-service-dir=" #$output "share/dbus-1")
             ;;(string-append "-Dwith-pam-limits-dir=" #$output "/etc/security/limits.d")
             "-Dwith-sd-bus-provider=elogind")))
   (native-inputs
    (list appstream dbus libinih pkg-config))
   (inputs
    (list elogind))
   (home-page "https://gitlab.freedesktop.org/hadess/iio-sensor-proxy")
   (synopsis "Optimise Linux system performance on demand")
   (description "Optimise Linux system performance on demand")
   (license license:bsd-3)))
