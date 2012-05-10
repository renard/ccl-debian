;; Rebuild full CCL system (both kernel and image)

;; http://ccl.clozure.com/ccl-documentation.html#Building-Everything
(ccl:rebuild-ccl :full t)


;; Debianize CCL (see http://lhealy.livejournal.com/11629.html)
(load "/usr/share/common-lisp/source/common-lisp-controller/common-lisp-controller.lisp")

;; Fix
;;  Error: Unbound variable: CCL::FASL-VERSION
;;  While executing: ASDF::LISP-VERSION-STRING, in process listener(1)
;; See http://permalink.gmane.org/gmane.lisp.openmcl.devel/7530
(defparameter ccl::fasl-version (ccl::target-fasl-version))

(mapcar #'load
 (common-lisp-controller:compile-common-lisp-controller-v5 "ccl"))

(common-lisp-controller:init-common-lisp-controller-v5 "ccl")

(ccl:save-application (if (member :X86 *features*) "ccl-deb" "ccl-deb64"))
