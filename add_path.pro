; docformat = 'rst'
;+
; Adds a user-selected directory structure to IDL's path through the !PATH 
; system variable. This change is local to the current IDL session. 
;
; :requires:
;  IDL 6.0
; 
; :examples:
;  See the main program at the end of the file.
; 
; :author:
;  Mark Piper, ITT VIS, 2009
;-
pro add_path, dir
   compile_opt idl2

   if n_elements(dir) eq 0 || file_test(dir, /directory) eq 0 then begin
      message, 'Directory not found. Returning.', /informational
      return
   endif
   !path += path_sep(/search_path) + expand_path('+' + file_expand_path(dir))
end

;+
; Example
;-
dir = dialog_pickfile(/directory, title='Please select a directory...')
add_path, dir
end

