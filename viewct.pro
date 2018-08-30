; docformat = 'rst'
;+
; A tool for viewing (not editing) the current color table. 
; 
; VIEWCT visualizes the current color table with a 16 x 16 table of colored 
; cells. Moving the cursor over the visualization displays the index into the 
; color table and the RGB color value at that index in a statusbar. 
; 
; Updating the current color table in IDL will force VIEWCT to update when
; it's popped to the foreground. R-clicking and selecting "Refresh" will
; also update VIEWCT.
; 
; :pre:
;  The Direct Graphics indexed color mode must be set 
;  (i.e., device, decomposed=0)
; 
; :author:
;  Mark Piper, ITT VIS, 2009
;-

;+
; The primary event handler for VIEWCT. 
;
; :params:
;    event
;-
pro viewct_event, event
   compile_opt idl2, hidden
   
   widget_control, event.top, get_uvalue=pstate
   
   if event.type eq 4 then viewct_refresh, pstate
   
   if event.release eq 4 then $
      widget_displaycontextmenu, event.id, event.x, event.y, (*pstate).wcontext
      
   (*pstate).current_index = (*pstate).table[event.x, event.y]
   sindex = string((*pstate).current_index, format='(i3)')
   widget_control, (*pstate).windex, set_value=sindex
   
   (*pstate).current_rgb = (*pstate).ct[(*pstate).current_index, *]
   srgb = string((*pstate).current_rgb, format='("[",i3,", ",i3,", ",i3,"]")')
   widget_control, (*pstate).wrgb, set_value=srgb
end


;+
; The event handler for the context menu. 
;
; :params:
;    event
;-
pro viewct_context, event
   compile_opt idl2, hidden
   
   widget_control, event.top, get_uvalue=pstate
   uname = widget_info(event.id, /uname)
   
   case uname of
   'refresh': viewct_refresh, pstate
   else:
   endcase
end


;+
; Gets the current color table & stores it in the state variable.
; Repaints the window.
;
; :params:
;    pstate
;-
pro viewct_refresh, pstate
   compile_opt idl2, hidden
   
   tvlct, r, g, b, /get
   (*pstate).ct = [[r], [g], [b]]
   tv, (*pstate).table
end


;+
; The cleanup routine. Deletes the state variable.
;
; :params:
;    wtop
;-
pro viewct_cleanup, wtop
   compile_opt idl2, hidden
   
   widget_control, wtop, get_uvalue=pstate
   ptr_free, pstate
end


;+
; The UI creation routine.
;-
pro viewct, ct
   compile_opt idl2

   if n_params() eq 0 then ct = bytarr(256,3)
   
   ; Make the color table image.
   n_cells = !d.table_size
   n_rows = sqrt(n_cells) ; default = 16
   cell_width = 25
   cell = indgen(n_rows, n_rows)
   table = bytscl(congrid(cell, n_rows*cell_width, n_rows*cell_width))
   
   wtop = widget_base( $
      /column, $
      title='Color Table Viewer')
   wct = widget_draw(wtop, $
      xsize=n_rows*cell_width, $
      ysize=n_rows*cell_width, $
      retain=0, $
      /expose_events, $
      /button_events, $
      /motion_events)
   winfobase = widget_base(wtop, $
      /row, $
      /align_center)
   windex_static = widget_label(winfobase, $
      value='Color index: ')
   windex = widget_label(winfobase, $
      value='000')
   wspacer = widget_label(winfobase, value='   ')
   wrgb_static = widget_label(winfobase, $
      value='RGB value: ')
   wrgb = widget_label(winfobase, $
      value='[255, 255, 255]')
      
   wcontext = widget_base(wtop, $
      /context_menu, $
      uname='context', $
      event_pro='viewct_context')
   wrefresh = widget_button(wcontext, $
      value='Refresh...', $
      uname='refresh')
      
   widget_control, wtop, /realize
   
   state = { $
      ct : ct, $
      table : table, $
      windex : windex, $
      wrgb : wrgb, $
      wcontext : wcontext, $
      current_index : 0, $
      current_rgb : bytarr(3) $
      }
   pstate = ptr_new(state, /no_copy)
   widget_control, wtop, set_uvalue=pstate

   viewct_refresh, pstate
   
   xmanager, 'viewct', wtop, $
      cleanup='viewct_cleanup', $
      /no_block
end
