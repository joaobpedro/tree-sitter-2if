;; Comments
(comment) @comment

;; Command keywords that are actually tokens
"HEAD" @keyword
"CONTROL" @keyword
"CROSS" @keyword
"GEOM" @keyword
"MATERIAL" @keyword
"CONTINT" @keyword
"HIST" @keyword
"TIME" @keyword
"GCLOAD" @keyword
"GPDISP" @keyword
"GLBON" @keyword
"VISRES" @keyword
"SMERGE" @keyword
"LMERGE" @keyword
"FRICMODEL" @keyword
"ROTATE" @keyword
"DISPLACE" @keyword

;; Constants that are actually defined in grammar
"AUTO" @constant.builtin

;; Numbers
(number) @number

;; Identifiers
(identifier) @variable

;; Command-specific highlights
(head_command) @string.documentation

;; Material name patterns
((identifier) @constant 
 (#match? @constant "^MAT_"))

;; Cross-section name patterns  
((identifier) @constant 
 (#match? @constant "^CS_"))