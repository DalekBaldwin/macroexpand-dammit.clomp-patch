(in-package #:cl-user)

(defpackage #:macroexpand-dammit.clomp-patch
  (:use #:cl)
  #.`(:import-from #:macroexpand-dammit
      ,@(loop for symbol being the present-symbols of :macroexpand-dammit
           when (not
                 (member
                  symbol
                  macroexpand-dammit.clomp-patch.patched-symbols::*patched-symbols*))
           collect (make-symbol (symbol-name symbol))))
  #.`(:export
      ,@(loop for symbol being the external-symbols of :macroexpand-dammit
           collect (make-symbol (symbol-name symbol)))))

(in-package #:macroexpand-dammit.clomp-patch)

(defparameter *system-directory*
  (make-pathname
   :directory
   (pathname-directory
    (asdf:system-definition-pathname "macroexpand-dammit.clomp-patch"))))
