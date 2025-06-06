;; inherits: python
;; extends

; Assignment type annotations
(assignment
  type: (type) @type.inner
)

(assignment
  ":" @_start
  .
  (type) @_end
  (#make-range! "type.outer" @_start @_end)
 )

; Function parameter
(typed_parameter
    type: (type) @type.inner
  )

(typed_parameter
    ":" @_start
    .
    type: (type) @_end
    (#make-range! "type.outer" @_start @_end)
  )

; Function return type
(function_definition
  return_type: (type) @type.inner
  )

; NOTE: This doesn't work properly, as it captures `)` together with ` ->`
; (function_definition
;   parameters: 
;   (parameters
;     ")" @_start
;     ) 
;   return_type: (type) @_end
;   (#make-range! "type.outer" @_start @_end)
; )

; NOTE: This works, but leaves a space ` ` before `->`
(function_definition
  "->" @_start
  return_type: (type) @_end
  (#make-range! "type.outer" @_start @_end)
)

; Add class 
(class_definition
  superclasses: 
    (argument_list
      (identifier) @call.inner
      ) @call.outer
  )
