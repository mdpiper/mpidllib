; docformat = 'rst'
;+
; Deletes all open Direct Graphics windows.
;
; :author:
;   Mark Piper, ITT VIS, 2009
;-
pro wdeleteall
   compile_opt idl2
   
   while !d.window ne -1 do wdelete, !d.window
end
