def fold(cond; next):
  def _fold:
    if cond then
      next | _fold
    end;
  _fold;

def fold(cond; next; extract):
  def _fold:
    if cond then
      next | _fold
    else
      extract
    end;
  _fold;

def while(cond; update; extract):
  def _while:
    if cond then
      extract, (update | _while)
    else empty end;
  _while;

def bin:
  if .<0 then
    "-"+(-.|bin)
  elif .==0 then
    "0"
  else
    [while(.>0; ./2|floor; .%2)]
    | reverse
    | join("")
  end;

def oct:
  if .<0 then
    "-"+(-.|bin)
  elif .==0 then
    "0"
  else
    [while(.>0; ./8|floor; .%8)]
    | reverse
    | join("")
  end;

def hex(upper):
  if .<0 then
    "-"+(-.|hex(upper))
  elif .==0 then
    "0"
  else
    (if upper then
      [range(0; 10), "A", "B", "C", "D", "E", "F"]
    else
      [range(0; 10), "a", "b", "c", "d", "e", "f"]
    end) as $chars |

    [while(.>0; ./16|floor; $chars[.%16])]
    | reverse
    | join("")
  end;

def hex:
  hex(false);

def chars:
  explode[] | [.] | implode;

def chars(n):
  n as $n |
  @text
  | foreach range(0; length; $n) as $i (explode;.;
    .[$i:$i+$n] | implode
  );

def rchars(n):
  n as $n |
  @text |
  (length%$n | if .==0 then
    $n
  end) as $start |
  foreach range($start; length+1; $n) as $i (explode;.;
    .[$i-$n | if .<0 then 0 end:$i] | implode
  );

def ljust(n; s): @text | .+(s|@text)*(n-length);
def rjust(n; s): @text | (s|@text)*(n-length)+.;
def center(n; s):
  @text |
  (n-length) as $f |
  ($f/2|floor) as $l |
  ($f-$l) as $r |
  (s|@text) as $s |
  $s*$l + @text + $s*$r;

def ljust(n): ljust(n; " ");
def rjust(n): rjust(n; " ");
def center(n): center(n; " ");

def strip(regex): regex as $r | gsub("^(?:\($r))+|(?:\($r))+\\Z"; "");
def lstrip(regex): regex as $r | sub("^(?:\($r))+"; "");
def rstrip(regex): regex as $r | sub("(?:\($r))+\\Z"; "");

def strip: strip("[ \\t\\r\\n]");
def lstrip: lstrip("[ \\t\\r\\n]");
def rstrip: rstrip("[ \\t\\r\\n]");

def lines: sub("\\r?\\n\\Z"; "") | debug | splits("\\r?\\n");
