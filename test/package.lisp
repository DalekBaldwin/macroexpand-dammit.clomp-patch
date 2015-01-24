(in-package :cl)

(defpackage :macroexpand-dammit.clomp-patch-test
  (:use :cl :macroexpand-dammit.clomp-patch :fiveam))

(in-package :macroexpand-dammit.clomp-patch-test)

(defparameter *system-directory*
  macroexpand-dammit.clomp-patch::*system-directory*)
