(defparameter version "0.0.1")
(load "./conjugations.lsp")
(sb-ext:save-lisp-and-die (concatenate 'string "./builds/classical-japanese-conjugations-" version) :executable t :toplevel #'main)
