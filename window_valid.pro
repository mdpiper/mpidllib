; docformat = 'rst'
;+
; :description:
;   Pass a window index to see if it's currently in use (i.e., valid). Pass
;   nothing to get a list of all valid DG windows.
;
; :params:
;   window_index: in, optional, type=integer
;
; :author:
;   Mark Piper, ITT VIS, 2008
;-
function window_valid, window_index
   compile_opt idl2
   
   device, window_state=ws
   is_valid = where(ws eq 1)

   return, n_params() eq 0 ? is_valid $
      : total(is_valid eq window_index, /preserve_type)
end


;+
; Examples.
;-
print, 'No windows open:', window_valid()
window, 14
print, 'Is window 14 open?', window_valid(14)
print, 'Is window 10 open?', window_valid(10)
print, 'All open windows:', window_valid()
end
