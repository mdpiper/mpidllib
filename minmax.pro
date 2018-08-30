;+
; Gives the minimum and maximum value of an array of real (e.g.,
; integer, float) numbers. No type conversion is performed.
;
; @param x {in}{type=numeric} An array of real numbers.
; @keyword range {optional}{type=boolean} Set to return the range of
;   the array, as well as the min and max values.
; @keyword _extra {optional} Keyword inheritance.
; @returns A two-element array giving the minimum and maximum values
;   of the input array; or, if the RANGE keyword is set, a
;   three-element array giving the min value, the max value and the
;   range of the input array.
; @requires IDL 5.3
; @author Mark Piper, 2003
;-
function minmax, x, range=r, _extra=e
  compile_opt idl2

  xmin = min(x, max=xmax, _extra=e)
  ret = [xmin, xmax]
  if keyword_set(r) then ret = [ret, xmax-xmin]
  return, ret
end
