(in-package :macroexpand-dammit.clomp-patch-test)

(def-suite :macroexpand-dammit-test)
(in-suite :macroexpand-dammit-test)

#-allegro
(declaim (type integer *declared-integer*))
#+allegro
(eval-when (:load-toplevel :execute)
  (proclaim '(type integer *declared-integer*)))

(defvar *declared-integer* 0)

(test let-global-type-declaration
  ;; Ensure that in the absence of a symbol-macro binding, no dummy binding is
  ;; imposed that would conflict with the type declaration for a global
  ;; variable.
  (is (=
       5
       (eval
        (macroexpand-dammit
         '(symbol-macrolet ((not-a-special-variable 1))
           (let ((*declared-integer* 2)
                 (not-a-special-variable 3))
             (+ *declared-integer* not-a-special-variable)))))))
  
  ;; In ANSI CL it is an error to establish a symbol-macro binding for an
  ;; existing global variable name, so no let binding for such a variable can
  ;; ever shadow a symbol-macro anyway.
  (signals error
    (macroexpand-dammit
     '(symbol-macrolet ((*declared-integer* 'foo))))))
