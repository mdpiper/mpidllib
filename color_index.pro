;+
; Creates a long integer color index from RGB coordinates or a string, 
; suitable for use in decomposed color mode in Direct Graphics.
;
; @param color {in}{required}{type=byte, or bytarr, or string} A 3-element 
;  byte array representing color or just red value(s); if red value(s) then 
;  g and b parameters should be present. Alternately, a string with the name
;  of a color included in the IDL 8.0 !color system variable
; @param g {in}{optional}{type=byte, or bytarr} Green value(s)
; @param b {in}{optional}{type=byte, or bytarr} Blue value(s)
; @returns A long integer index corresponding to the RGB triple, with
;   <em>blue</em> as the most significant bit; i.e, BGR order.
; @examples
; <pre>
; IDL> print, color_index(0,0,255) ; blue
;    16711680
; IDL> orange = color_index([255,160,0])
; IDL> device, decomposed=1
; IDL> plot, findgen(2), color=orange
; </pre>
; @requires IDL 5.3
; @history
;  2010-11, MP: Added ability to get color from string (IDL 8.0).
;-
function color_index, color, g, b
  compile_opt idl2
  on_error, 2
	
  case n_params() of
     1 : begin
        if (size(color, /tname) eq 'STRING') $
           && (float(!version.release) ge 8.0) then begin
           style_convert, color, color=color
        endif else if (n_elements(color) ne 3) then $
           message, 'Incorrect number of parameters.'
        ir = color[0]
        ig = color[1]
        ib = color[2]
     end
     3 : begin
        ir = color
        ig = g
        ib = b
     end
     else : message, 'Incorrect number of parameters.'
  endcase
  
  return, ir + (ig*2L^8) + (ib*2L^16)
end


;+
; Examples
;-
print, color_index(0,0,255) ; blue
orange = color_index([255,160,0])
device, decomposed=1
window, 1
plot, findgen(2), color=orange
print, color_index('dark sea green') ; this works for IDL 8.0
window, 2
plot, findgen(2), color=color_index('green')
end
