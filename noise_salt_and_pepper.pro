;+
; Introduces salt-and-pepper noise (randomly spaced white and black pixels)
; into a grayscale 8-bit image.
;
; @param image {in}{required}{type=2D byte array} A 2D array representing a
;  grayscale 8-bit image.
; @param n_noisy {in}{required}{type=numeric} The number of noisy pixels
;  requested in the image. If the PERCENT keyword is set, this number is a
;  percentage on [0,100]. There must be at least two noisy pixels.
; @keyword percent {optional}{type=boolean} Set this keyword to interpret
;  the n_noisy parameter as a percentage on [0,100].
; @keyword seed {in}{optional}{type=numeric} A seed value to be used by
;  the random number generator.
;
; @examples
; <pre>
; IDL> noise_salt_and_pepper_ex
; </pre>
; @todo Extend to multi-channel images and images with bit depths other than 8.
; @requires IDL 6.0
; @author Mark Piper, ITT VIS, 2007
; @version $Id: noise_salt_and_pepper.pro 51 2008-07-07 20:09:08Z mpiper $
;-
function noise_salt_and_pepper, image, n_noisy, seed=seed, percent=percent
   compile_opt idl2
   
   catch, err
   if err ne 0 then begin
      catch, /cancel
      print, !error_state.msg
      return, 0
   endif
   
   if n_params() ne 2 then $
      message, 'IMAGE and N_NOISY parameters required.'
      
   info = size(image, /structure)
   if info.n_dimensions ne 2 then $
      message, 'A grayscale image is required.'
   if info.type ne 1 then $
      message, 'An 8-bit image is required.'
      
   _seed = n_elements(seed) gt 0 ? seed : systime(1)
   
   ; If the percent keyword is set, interprent the n_noisy parameter
   ; as a percentage. Otherwise, n_noisy is the number of noisy pixels
   ; requested. There must be at least two noisy pixels.
   if keyword_set(percent) then begin
      _n_noisy = ((n_noisy > 0.0) < 100.0)*info.n_elements/100.0
   endif else _n_noisy = (n_noisy > 0) < info.n_elements
   if _n_noisy lt 2 then $
      message, 'There must be at least two noisy pixels.'
      
   ; Half of the noisy pixels are black, the other half are white.
   i_noisy = randomu(_seed, _n_noisy)*info.n_elements
   white_points = i_noisy[0:_n_noisy-1:2]
   black_points = i_noisy[1:_n_noisy-1:2]
   
   noisy = image
   noisy[white_points] = 255B
   noisy[black_points] = 0B
   return, noisy
end


;+
; Main-level program example of calling NOISE_SALT_AND_PEPPER.
;-

image = bytscl(dist(200))
noisy = noise_salt_and_pepper(image, 5, /percent)
window, xsize=400, ysize=400, retain=2, $
   title='NOISE_SALT_AND_PEPPER Example'
loadct, 5
tv, image, 0
tv, noisy, 1
plot, histogram(image), /noerase, position=[0.10, 0.10, 0.95, 0.45], $
   xtitle='pixel value', ytitle='frequency', title='Image Histograms'
oplot, histogram(noisy), color=150

end
