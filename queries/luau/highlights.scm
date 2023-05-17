; Preproc

(hash_bang_line) @preproc

;; Keywords

"return" @keyword.return

[
 "local"
 "type"
 "export"
] @keyword

(do_statement
[
  "do"
  "end"
] @keyword)

(while_statement
[
  "while"
  "do"
  "end"
] @repeat)

(repeat_statement
[
  "repeat"
  "until"
] @repeat)

[
  (break_statement)
  (continue_statement)
] @repeat

(if_statement
[
  "if"
  "elseif"
  "else"
  "then"
  "end"
] @conditional)

(elseif_statement
[
  "elseif"
  "then"
  "end"
] @conditional)

(else_statement
[
  "else"
  "end"
] @conditional)

(for_statement
[
  "for"
  "do"
  "end"
] @repeat)

(function_declaration
[
  "function"
  "end"
] @keyword.function)

(function_definition
[
  "function"
  "end"
] @keyword.function)

;; Operators

[
  "and"
  "not"
  "or"
  "in"
  "typeof"
] @keyword.operator

[
  "+"
  "-"
  "*"
  "/"
  "%"
  "^"
  "#"
  "=="
  "~="
  "<="
  ">="
  "<"
  ">"
  "="
  "&"
  "~"
  "|"
  "?"
  "//"
  ".."
  "+="
  "-="
  "*="
  "/="
  "%="
  "^="
  "..="
] @operator

;; Variables

(identifier) @variable

; Types

(type (identifier) @type)

(type (generic_type (identifier) @type))

(builtin_type) @type.builtin

((identifier) @type
  (#lua-match? @type "^[A-Z]"))

; Typedefs

(type_definition "type" . (type) @type.definition "=")

; Constants

((identifier) @constant
 (#lua-match? @constant "^[A-Z][A-Z_0-9]+$"))

; Builtins

((identifier) @constant.builtin
  (#eq? @constant.builtin "_VERSION"))

((identifier) @variable.builtin
  (#eq? @variable.builtin "self"))

((identifier) @namespace.builtin
  (#any-of? @namespace.builtin "_G" "debug" "io" "jit" "math" "os" "package" "string" "table" "utf8"))

((identifier) @keyword.coroutine
  (#eq? @keyword.coroutine "coroutine"))

;; Tables

(field name: (identifier) @field)

(dot_index_expression field: (identifier) @field)

(object_type (identifier) @field)

(table_constructor
[
  "{"
  "}"
] @constructor)

; Functions

(parameter . (identifier) @parameter)
(function_type (identifier) @parameter)

(function_call name: (identifier) @function.call)
(function_declaration name: (identifier) @function)

(function_call name: (dot_index_expression field: (identifier) @function.call))
(function_declaration name: (dot_index_expression field: (identifier) @function))

(method_index_expression method: (identifier) @method.call)

(function_call
  (identifier) @function.builtin
  (#any-of? @function.builtin
    ;; built-in functions in Lua 5.1
    "assert" "collectgarbage" "dofile" "error" "getfenv" "getmetatable" "ipairs"
    "load" "loadfile" "loadstring" "module" "next" "pairs" "pcall" "print"
    "rawequal" "rawget" "rawlen" "rawset" "require" "select" "setfenv" "setmetatable"
    "tonumber" "tostring" "type" "unpack" "xpcall" "typeof"
    "__add" "__band" "__bnot" "__bor" "__bxor" "__call" "__concat" "__div" "__eq" "__gc"
    "__idiv" "__index" "__le" "__len" "__lt" "__metatable" "__mod" "__mul" "__name" "__newindex"
    "__pairs" "__pow" "__shl" "__shr" "__sub" "__tostring" "__unm"))

; Literals

(number) @number

(string) @string @spell

(nil) @constant.builtin

(vararg_expression) @variable.builtin

[
  (false)
  (true)
] @boolean

;; Punctuations

[
  ";"
  ":"
  "::"
  ","
  "."
  "->"
] @punctuation.delimiter

[
 "("
 ")"
 "["
 "]"
 "{"
 "}"
] @punctuation.bracket

(variable_list
   attribute: (attribute
     (["<" ">"] @punctuation.bracket
      (identifier) @attribute)))

(generic_type [ "<" ">" ] @punctuation.bracket)
(generic_type_list [ "<" ">" ] @punctuation.bracket)

; Comments

(comment) @comment @spell

((comment) @comment.documentation
  (#lua-match? @comment.documentation "^[-][-][-]"))

((comment) @comment.documentation
  (#lua-match? @comment.documentation "^[-][-](%s?)@"))

; Errors

(ERROR) @error
