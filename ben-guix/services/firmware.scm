(define-module (ben-guix services firmware)
  #:use-module (gnu packages)
  #:use-module (gnu services)
  #:use-module (gnu services dbus)
  #:use-module (gnu services shepherd)
  #:use-module (gnu services desktop)
  #:use-module (guix records)
  #:use-module (guix gexp)
  #:use-module (guix profiles)
  #:use-module (ben-guix packages firmware))

(define (fwupd-shepherd-service package)
  "Return a Shepherd service to start fwupd."
  (list (shepherd-service
         (requirement '(dbus-system))
         (provision '(fwupd-nonfree-ben))
         (start #~(make-forkexec-constructor
                   (list #$(file-append package "/libexec/fwupd/fwupd"))))
         (stop #~(make-kill-destructor)))))

(define-public fwupd-service-type
  (service-type
   (name 'fwupd-nonfree-ben)
   (description "Setup the firmware update deamon.")
   (default-value fwupd-nonfree-ben)
   (extensions
    (list
     (service-extension profile-service-type list)
     (service-extension polkit-service-type list)
     (service-extension dbus-root-service-type list)
     (service-extension shepherd-root-service-type
                        fwupd-shepherd-service)))))
