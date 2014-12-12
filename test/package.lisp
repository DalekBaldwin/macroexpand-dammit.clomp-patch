(in-package :cl)

(defpackage :macroexpand-dammit.clomp-patch-test
  (:use :cl :macroexpand-dammit.clomp-patch :fiveam))

(in-package :macroexpand-dammit.clomp-patch-test)

(defparameter *system-directory*
  (make-pathname
   :directory 
   (slot-value
    (asdf:system-definition-pathname :macroexpand-dammit.clomp-patch)
    'directory)))
