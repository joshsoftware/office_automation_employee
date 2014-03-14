# ============================================================
# * Bootstrap: rowlink.js v3.1.0
# * http://jasny.github.io/bootstrap/javascript/#rowlink
# * ============================================================
# * Copyright 2012-2014 Arnold Daniels
# *
# * Licensed under the Apache License, Version 2.0 (the "License");
# * you may not use this file except in compliance with the License.
# * You may obtain a copy of the License at
# *
# * http://www.apache.org/licenses/LICENSE-2.0
# *
# * Unless required by applicable law or agreed to in writing, software
# * distributed under the License is distributed on an "AS IS" BASIS,
# * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# * See the License for the specific language governing permissions and
# * limitations under the License.
# * ============================================================ 
+($) ->
  "use strict"
  Rowlink = (element, options) ->
    @$element = $(element)
    @options = $.extend({}, Rowlink.DEFAULTS, options)
    @$element.on "click.bs.rowlink", "td:not(.rowlink-skip)", $.proxy(@click, this)
    return

  Rowlink.DEFAULTS = target: "a"
  Rowlink::click = (e) ->
    target = $(e.currentTarget).closest("tr").find(@options.target)[0]
    return e.preventDefault()  if $(e.target)[0] is target
    if target.click
      target.click()
    else if document.createEvent
      evt = document.createEvent("MouseEvents")
      evt.initMouseEvent "click", true, true, window, 0, 0, 0, 0, 0, false, false, false, false, 0, null
      target.dispatchEvent evt
    return

  
  # ROWLINK PLUGIN DEFINITION
  # ===========================
  old = $.fn.rowlink
  $.fn.rowlink = (options) ->
    @each ->
      $this = $(this)
      data = $this.data("rowlink")
      $this.data "rowlink", (data = new Rowlink(this, options))  unless data
      return


  $.fn.rowlink.Constructor = Rowlink
  
  # ROWLINK NO CONFLICT
  # ====================
  $.fn.rowlink.noConflict = ->
    $.fn.rowlink = old
    this

  
  # ROWLINK DATA-API
  # ==================
  $(document).on "click.bs.rowlink.data-api", "[data-link=\"row\"]", (e) ->
    $this = $(this)
    return $this.rowlink($this.data())  if $this.data("rowlink")
    $(e.target).trigger "click.bs.rowlink"
    return

  return
(window.jQuery)
