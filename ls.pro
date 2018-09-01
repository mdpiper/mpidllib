; docformat = 'rst'
;+
; Prints a listing of the current directory.
; 
; :author:
;  Mark Piper, University of Colorado, 2018
;
;-
pro ls
  compile_opt idl2

  pm, file_search(/mark_directory)
end
