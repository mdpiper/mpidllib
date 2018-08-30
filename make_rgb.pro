; docformat = 'rst'
;+
; Creates a 24-bit RGB image from an indexed image, with an optional 
; colormap. The input image is scaled into the byte range. 
;
; :params:
;   image: in, required, type=numeric
;      Image pixel data in a 2D array.
;   r
;   g
;   b
;
; :keywords:
;   rgb_table: in, optional, type=integer
;      An IDL color table number in the range 0-40.
;   interleave: in, optional, type=integer
;      The interleaving of the RGB image: 0=BIP (default), 1=BIL, 2=BSQ
;
; :examples:
;   See the attached main program.
;
; :author:
;   Mark Piper, ITT VIS, 2008
;-
function make_rgb, image, r, g, b, $
      rgb_table=ct_number, $
      interleave=inter
   compile_opt idl2
   
   ; Image data must be byte or they're scaled to byte.
   _image = bytscl(image)
   
   ; TODO: Implement R, G and B parameters.
   
   if n_elements(ct_number) gt 0 then begin
      ct_number = (ct_number > 0) < 40
      loadct, ct_number, /silent
      tvlct, r, g, b, /get
   endif else begin
      r = bindgen(256)
      g = r
      b = r
   endelse
   
   if n_elements(inter) eq 0 then begin
      inter = 0
   endif else begin
      inter = (inter > 0) < 2
   endelse

   ; This technique gives a BSQ result.
   _image = [[[r[_image]]], [[g[_image]]], [[b[_image]]]]

   ; J. Larsen (US Army Dugway Proving Grounds) gave me the idea for using
   ; TRANSPOSE to change the band interleaving.
   case inter of
      0: _image = transpose(_image, [2,0,1])
      1: _image = transpose(_image, [0,2,1])
      2:
      else:
   endcase

   return, _image
end


;+
; Example main program.
;-
file = file_which('ctscan.dat')
scan = read_binary(file, data_dims=[256,256])
scan_bip = make_rgb(scan, rgb_table=15)
help, scan, scan_bip
iimage, scan_bip
end
