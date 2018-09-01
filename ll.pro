; docformat = 'rst'
;+
; Prints a long listing of the current directory, including hidden files.
; 
; :author:
;  Mark Piper, University of Colorado, 2018
;
;-
pro ll
  compile_opt idl2

  spawn, 'ls -al'
end
