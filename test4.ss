(import (chezscheme) (rachez parser))
(display (parse-string digit/p "123"))
(display (parse-string (many/p digit/p) "123abv"))