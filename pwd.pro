; docformat = 'rst'
;+
; Prints the current working directory.
;-
pro pwd
  compile_opt idl2

  cd, current=c
  print, c
end
