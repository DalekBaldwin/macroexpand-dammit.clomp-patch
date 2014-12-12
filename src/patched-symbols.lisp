(in-package :cl)

(defpackage :macroexpand-dammit.clomp-patch.patched-symbols
  (:use :cl))

(in-package :macroexpand-dammit.clomp-patch.patched-symbols)

(defparameter *patched-symbols*
  '(macroexpand-dammit::*form-handler*
    macroexpand-dammit::defhandler
    macroexpand-dammit::hander-let ;; typo in original
    macroexpand-dammit::m
    macroexpand-dammit::macroexpand-dammit
    macroexpand-dammit::macroexpand-dammit-as-macro
    macroexpand-dammit::macroexpand-dammit-expansion))
