Provide some simple formatting functions for jq language

For example, `hex`, `strip`, `rjust` and `lines`

Import
-------------------------------------------------------------------------------
```jq
include "string-fmt";
hex
```
or
```jq
import "string-fmt" as fmt;
fmt::hex
```

Examples
===============================================================================
```sh
$ jq -n 'include "string-fmt"; 9144|hex'
"23b8"
$ jq -n 'include "string-fmt"; 9144|hex|rjust(8)'
"    23b8"
$ jq -n 'include "string-fmt"; 9144|hex|center(8)'
"  23b8  "
$ jq -n 'include "string-fmt"; 9144|hex|rjust(8; 0)'
"000023b8"
$ jq -n 'include "string-fmt"; 9144|hex|rjust(8; 0)|chars'
"0"
"0"
"0"
"0"
"2"
"3"
"b"
"8"
$ jq -n 'include "string-fmt"; 9144|hex|rjust(8; 0)|chars(2)'
"00"
"00"
"23"
"b8"
```
