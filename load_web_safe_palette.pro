;+
; Loads a web-safe color palette of 216 colors. The highest 256-216=40 colors
; are set to white [255,255,255]. 
; 
; Reference: <a href="http://en.wikipedia.org/wiki/Web_colors">
; http://en.wikipedia.org/wiki/Web_colors</a>
;
; @examples
; <pre>
; IDL> device, decomposed=0 ; set indexed color
; IDL> load_web_safe_palette
; % Web-safe palette loaded.
; IDL> xpalette ; view palette
; </pre>
; @author Mark Piper, ITT VIS, 2007
;-
pro load_web_safe_palette
   compile_opt idl2
   
   ; Initialize palette to white.
   top = 255B
   full = bytarr(!d.table_size) + top
   tvlct, full, full, full
   
   ; Define the web-safe intensities [0,51,102,153,204,255].
   n_int = 6
   int = byte(top*findgen(n_int)/(n_int-1))
   
   ; Define the red, green and blue color channels from the intensities.
   rc = reform(rebin(int, n_int, n_int, n_int), n_int^3)
   gc = rebin(int, n_int^3, /sample)
   bc = rebin(reform(rebin(int, n_int, n_int), n_int^2), n_int^3, /sample)
   
   ; Load the color channels.
   tvlct, rc, gc, bc
   message, 'Web-safe palette loaded.', /noname, /informational
end
