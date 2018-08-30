; docformat = 'rst'
;+
; A convenience routine that flattens/linearizes a multidimensional array. 
; An improvement over REFORM because you don't need the final array dimensions.
; 
; :params:
;  x : in, required, type=any array
;   An array of any type to be converted to a vector.
;
; :author:
;  Mark Piper, VIS, 2011
;-
function flatten, x
   compile_opt idl2
   
   nx = n_elements(x)
   return, nx gt 0 ? reform(x, nx) : 0
end

; Example.
a = indgen(5, 7)
b = flatten(a)
c = reform(a, n_elements(a))
help, a, b, c
print, 'Results are equivalent? ', array_equal(b, c) ? 'Y' : 'N'
end

