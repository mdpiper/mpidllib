;+
; This function evaluates whether an input argument is of a numeric or
; non-numeric IDL type, based on the return from the SIZE function.
; Note that complex numbers aren't considered numeric by default (this
; is my choice). Set the COMPLEX keyword to toggle this behavior.
;
; @param arg {in} A variable or expression to test.
; @keyword complex {optional}{type=boolean} Set this keyword to consider
;  single and double complex types as numeric.
; @returns 1L if the argument is of an IDL numeric type, 0L if not.
; @examples
; <pre>
; IDL> print, is_numeric(4.6)
;           1
; IDL> print, is_numeric('4.6')
;           0
; IDL> print, is_numeric(!d)
;           0
; IDL> print, is_numeric(!d.window)
;           1
; IDL> print, is_numeric(complex(1,0))
;           0
; IDL> print, is_numeric(complex(1,0), /complex)
;           1
; </pre>
; @requires 6.0
; @categories math, type, numeric
; @author Mark Piper, ITT VIS, 2006
;-
function is_numeric, arg, complex=complex
  compile_opt idl2
  on_error, 2

  type = size(arg, /type)

  if type eq 0 then return, 0
  if keyword_set(complex) then begin
     non_types = [7, 8, 10, 11]
     if total(type eq non_types) eq 1 then return, 0
  endif else $
     if type ge 6 && type le 11 then return, 0
  
  return, 1
end
