;;;; macroexpand-dammit.clomp-patch.asd

(defpackage :macroexpand-dammit.clomp-patch-system
  (:use :cl :asdf))
(in-package :macroexpand-dammit.clomp-patch-system)

(defsystem :macroexpand-dammit.clomp-patch
  :name "macroexpand-dammit.clomp-patch"
  :serial t
  :components
  ((:static-file "macroexpand-dammit.clomp-patch.asd")
   (:module :src
            :components ((:file "patched-symbols")
                         (:file "package")
                         (:file "macroexpand-dammit.clomp-patch"))
            :serial t))
  :depends-on (:macroexpand-dammit))

(defsystem :macroexpand-dammit.clomp-patch-test
  :name "macroexpand-dammit.clomp-patch-test"
  :serial t
  :components
  ((:module :test
            :components ((:file "package")
                         (:file "macroexpand-dammit.clomp-patch-test"))
            :serial t))
  :depends-on (:macroexpand-dammit.clomp-patch :fiveam))
