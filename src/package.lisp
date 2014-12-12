(in-package :cl)

(defpackage :macroexpand-dammit.clomp-patch
  (:use :cl)
  #.`(:import-from :macroexpand-dammit
      ,@(loop for symbol being the present-symbols of :macroexpand-dammit
             when (not
                   (member
                    symbol
                    macroexpand-dammit.clomp-patch.patched-symbols::*patched-symbols*))
           collect (intern (symbol-name symbol) :keyword)))
  #.`(:export
      ,@(loop for symbol being the external-symbols of :macroexpand-dammit
           collect (intern (symbol-name symbol) :keyword))))

(in-package :macroexpand-dammit.clomp-patch)

(defparameter *system-directory*
  (make-pathname
   :directory 
   (slot-value
    (asdf:system-definition-pathname :macroexpand-dammit.clomp-patch)
    'directory)))
