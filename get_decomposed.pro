;+
; Returns the IDL Direct Graphics color mode.
;
; @examples
; <pre>
; IDL> print, get_decomposed()
;           0
; </pre>
; @returns 1 for decomposed color mode, 0 for indexed color mode and
;  -1 for an invalid graphics device.
; @requires 5.3
; @author Mark Piper, 2005
;-
function get_decomposed
   compile_opt idl2
   
   dev = strlowcase(!d.name)
   if ~(dev eq 'win' || dev eq 'x') then begin
      message, 'No decomposed setting for device ' + !d.name, /info
      return, -1
   endif
   
   device, get_decomposed=d
   return, d
end

; Example
print, get_decomposed()
end
