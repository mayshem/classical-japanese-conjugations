(defparameter *conjs-file-path* "./conjugations.csv")
;; set the file storing conjugations

(defparameter *hiragana* '(#\あ #\い #\う #\え #\お #\か #\き #\く #\け #\こ #\が #\ぎ #\ぐ #\げ #\ご #\さ #\し #\す #\せ #\そ #\ざ #\じ #\ず #\ぜ #\ぞ #\た #\ち #\つ #\て #\と #\だ #\ぢ #\づ #\で #\ど #\な #\に #\ぬ #\ね #\の #\は #\ひ #\ふ #\へ #\ほ #\ぱ #\ぴ #\ぷ #\ぺ #\ぽ #\ば #\び #\ぶ #\べ #\ぼ #\ま #\み #\む #\め #\も #\や #\ゆ #\よ #\ら #\り #\る #\れ #\ろ #\わ #\ゐ #\ゑ #\を #\ん))

(defvar conjs-file-stream)
(setf conjs-file-stream (open *conjs-file-path* :direction :input))
;; open the file

(defun split-csv-line (string)
    "Splits a line of a CSV file into a list."
    (loop for i = 0 then (1+ j)
          as j = (position #\, string :start i)
          collect (subseq string i j)
          while j))

(defvar keys (split-csv-line (read-line conjs-file-stream)))

(defvar verbs
    (loop for line = (read-line conjs-file-stream nil nil)
          until (equalp nil line)
          collect (split-csv-line line)))

(defun pick-random-form-index ()
    "Picks a random form of the 5 remaining."
    (let ((number (+ 1
                     (random 5))))
         (if (>= number 3)
             (+ 1 number)
             number)))

(defun get-活用 (verb)
    (nth 0 verb))
(defun get-未然形 (verb)
    (nth 1 verb))
(defun get-連用形 (verb)
    (nth 2 verb))
(defun get-終止形 (verb)
    (nth 3 verb))
(defun get-連体形 (verb)
    (nth 4 verb))
(defun get-已然形 (verb)
    (nth 5 verb))
(defun get-命令形 (verb)
    (nth 6 verb))
(defun get-英語 (verb)
    (nth 7 verb))

(defun kanap (kana)
    (member kana *hiragana*))

(defun furiganize (str)
    "Remove kanji from a string and replace with their embedded reading."
    (format nil "~{~A~}" (remove nil (loop for c across str collect (if (kanap c) c nil)))))

(defun ask-question ()
    "Asks a question, tests if answer is right."
    (setf *random-state* (make-random-state t)) ; set the random state on call. this is to prevent the system from using the random state from the compile-time.
    (let ((form-number (pick-random-form-index))
          (verb (nth (random (length verbs)) verbs)))
        (format t "~&Verb: ~a (~a); Conjugation: ~a; Form: ~a~&" (get-終止形 verb) (get-英語 verb) (get-活用 verb) (nth form-number keys))
        (let ((line (read-line)))
             (if
                (or (equalp line (furiganize (nth form-number verb)))
                    (equalp line (nth form-number verb)))
                (format t "~&Correct!~&")
                (format t "~&Incorrect: ~a is the right answer.~&" (nth form-number verb))))))

(defun main ()
    (loop
        repeat 10
        do (ask-question)))


