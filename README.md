# classical-japanese-conjugations
This is a tool for practicing the conjugations of Classical Japanese written in Common Lisp, developed with SBCL 2.1.11 but it should be compatible with other implementations of Common Lisp.
When run it will select a random verb and form from the 5 non-終止形 forms, present the user with the verb in the 終止形, its conjugation class (i.e. 下二段活用), and the requested form. It will then wait for the user to enter their answer, test if it is correct, and respond as such, repeating this cycle 10 times before exiting.

To run, execute `(load "./conjugations.lsp")` in your Lisp environment.
To compile, load the `compile.lsp` script while in SBCL. Releases compiled with Steel Bank Common Lisp 2.1.11.
