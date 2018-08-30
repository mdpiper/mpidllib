;+
; Converts a color-indexed image into an RGB image. (The inverse of
; COLOR_QUAN, get it?!)
;
; @param image {in}{required}{type=numeric} A 2D rectangular array
;  representing an image.
; @param r {in}{required}{type=numeric} A 1D vector representing the
;  red components of the input image's color palette.
; @param g {in}{required}{type=numeric} A 1D vector representing the
;  green components of the input image's color palette.
; @param b {in}{required}{type=numeric} A 1D vector representing the
;  blue components of the input image's color palette.
;
; @returns An RGB image with BSQ interleaving.
; @examples
; <pre>
; IDL> file = filepath('avhrr.png', subdir=['examples','data'])
; IDL> earth_indexed = read_png(file, r, g, b)
; IDL> earth_rgb = color_quan_inv(earth_indexed, r, g, b)
; IDL> help, earth_indexed, earth_rgb
; EARTH_INDEXED   BYTE      = Array[720, 360]
; EARTH_RGB       BYTE      = Array[720, 360, 3]
; IDL> window, xsize=720, ysize=360
; IDL> tv, earth_rgb, true=3
; </pre>
;
; @todo Think of a better name for this routine.
; @requires IDL 6.0
; @author Mark Piper, ITT VIS, 2006
;-
function color_quan_inv, image, r, g, b
    compile_opt idl2

    return, [[[r[image]]], [[g[image]]], [[b[image]]]]
end
