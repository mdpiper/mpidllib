; docformat = 'rst'
;+
; Prints the directories in IDL's path to the Console, one 
; directory per line.
;  
; :author:
;  Mark Piper, ITT VIS, 2009
;
; :version:
;  $Id: print_path.pro 151 2009-07-09 22:40:59Z mpiper $
;-
pro print_path
  compile_opt idl2
  
  str = !version.os_family eq 'Windows' ? ';' : ':' 
  dirs = strsplit(!path, str, /extract)
  print, 'Directories in path:', n_elements(dirs)
  print, dirs, format='(a)'
end
