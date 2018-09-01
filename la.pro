; docformat = 'rst'
;+
; Prints a listing of the current directory, including hidden files.
; 
; :author:
;  Mark Piper, University of Colorado, 2018
;
;-
pro la
  compile_opt idl2

  pm, file_search(/mark_directory, /match_initial_dot)
end
