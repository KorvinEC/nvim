;; inherits: python
;; extends

; Assignment type annotations
(assignment 
  ":" @type.outer 
  . 
  (type) @type.inner @type.outer)

; Function parameter
(typed_parameter 
  ":" @type.outer 
  . 
  (type) @type.inner @type.outer)

; Function return type
(function_definition 
  "->" @type.outer
  . 
  (type) @type.inner @type.outer)
