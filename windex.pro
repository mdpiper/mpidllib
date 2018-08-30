;+
; Returns an array of open Direct Graphics window indices.
;
; @examples
; <pre>
; IDL> window, 23
; IDL> window, 5
; IDL> print, windex()
;           5          23
; </pre>
; @author Mark Piper, RSI, 2004
;-
function windex
   compile_opt idl2
   
   bang_d_name = strlowcase(!d.name)
   if ~(bang_d_name eq 'win' || bang_d_name eq 'x') then begin
      message, 'Not available for this device.', /info
      return, -1
   endif
  
   device, window_state=w
   ids = where(w eq 1, n_ids)
   return, n_ids gt 0 ? ids : -1
end
