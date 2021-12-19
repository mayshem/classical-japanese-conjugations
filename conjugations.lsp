(defparameter conjs-file-path "./conjugations.csv")

(defvar conjs-file-stream)
(setf conjs-file-stream (open conjs-file-path :direction :input))

(defun split-csv-line (string)
    "Splits a line of a CSV file into a list."
    (loop
        for i = 0 then (1+ j)
        as j = (position #\, string :start i)
        collect (subseq string i j)
        while j))

(defvar keys (split-csv-line (read-line conjs-file-stream)))

(defvar verbs
    (loop
        for line = (read-line conjs-file-stream nil nil)
        until (equalp nil line)
        collect (split-csv-line line)))

(defun pick-random-form-index ()
    "Picks a random form of the 5 remaining."
    (let (
        (number (+
            1
            (random 5))))
        (if
            (>= number 3)
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

(defun ask-question ()
    "Asks a question, tests if answer is right."
    (let
        (
            (form-number (pick-random-form-index))
            (verb (nth (random (length verbs)) verbs)))
        (format t "~&Verb: ~a (~a); Conjugation: ~a; Form: ~a~&" (get-終止形 verb) (get-英語 verb) (get-活用 verb) (nth form-number keys))
        (if
            (equalp (read-line) (nth form-number verb))
            (format t "~&Correct!~&")
            (format t "~&Incorrect: ~a is the right answer.~&" (nth form-number verb)))))

(defun main ()
    (loop
        repeat 10
        do (ask-question))
    (close conjs-file-stream))


