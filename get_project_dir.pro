; docformat = 'rst'
;+
; This function returns the absolute file path to the top directory
; of a project. Use it in conjunction with FILEPATH to reference files
; relative to the top directory.
;
; :pre:
;  This file must reside in a subdirectory of the project, ideally lib/.
;  
; :keywords:
;  data_dir : in, optional, type=boolean
;   Set this keyword to return the project's data directory path.
; 
; :examples:
;  See the example main program below.
; 
; :requires:
;  IDL 6.2
; 
; :author:
;  Mark Piper, ITT VIS, 2009
;-
function get_project_dir, data_dir=data
	compile_opt idl2

   s = scope_traceback(/structure)
   n= n_elements(s)
   base = file_dirname(file_dirname(s[n-1].filename), /mark_directory)
   return, keyword_set(data) ? base + 'data' + path_sep() : base
end


;+
; Example main program.
;-
print, 'Project directory:', get_project_dir(), format='(a)'
print, 'Data directory:', get_project_dir(/data), format='(a)'
end
