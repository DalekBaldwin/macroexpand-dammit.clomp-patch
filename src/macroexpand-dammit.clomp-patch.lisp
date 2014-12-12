(in-package :macroexpand-dammit.clomp-patch)

(defparameter *form-handler*
  (make-hash-table))

;; copy old handlers
(maphash
 (lambda (key val)
   (setf (gethash key *form-handler*) val))
 macroexpand-dammit::*form-handler*)

;; macro definition copied, but now references package-local symbol for *form-handler*
(defmacro defhandler (symbol lambda-list &body body)
  (let ((syms (force-list symbol)))
    (let ((func (intern (format nil "~A~A" 'hander- (first syms)))))
      `(progn
         (defun ,func ,lambda-list
           ,@body)
         (setf
          ,@(loop for sym in syms
               collect `(gethash ',sym *form-handler*)
               collect `',func))))))

;; actual handler we want to change
(defhandler let (let bindings &rest body)
  (let* ((names (loop for binding in bindings 
                   collect 
                     (force-first binding)))
         ;; patch here:
         (symbol-macrolet-names
          (loop for name in names
             when (nth-value 1 (macroexpand-1 name *env*))
             collect name)))
    `(list*
      ',let
      (list 
       ,@(loop for binding in bindings
            collect 
              (if (symbolp binding)
                  `',binding
                  `(list ',(first binding)
                         ,@(e-list (rest binding))))))
      (with-imposed-bindings
        (,let ,symbol-macrolet-names ;; and reference here
          (declare (ignorable ,@symbol-macrolet-names)) ;; and here
          (m-list ,@body))))))

;; finally, make sure external API calls use new *form-handlers*
;; then pass API call through to original package

(defmacro m (form &environment *env*)
  (let ((macroexpand-dammit::*form-handler*
         macroexpand-dammit.clomp-patch::*form-handler*))
    (macroexpand-dammit::m form)))

(defun macroexpand-dammit (form &optional *env*)
  (let ((macroexpand-dammit::*form-handler*
         macroexpand-dammit.clomp-patch::*form-handler*))
    (macroexpand-dammit:macroexpand-dammit form *env*)))

(defmacro macroexpand-dammit-as-macro (form)
  `(m ,form))

(defun macroexpand-dammit-expansion (form &optional *env*)
  (let ((macroexpand-dammit::*form-handler*
         macroexpand-dammit.clomp-patch::*form-handler*))
    (macroexpand-dammit::macroexpand-dammit-expansion form *env*)))
