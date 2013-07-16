lambda-calculus
===============

Verbose encoding
a(x) => [:x]
a(*XY) => [:*, a(X), a(Y)]
a(\x.A) => [:x, a(A)]

Brief encoding
a(x) => :x
a(*XY) => [:*, a(X), a(Y)]
a(\x.A) => [:x, a(A)]

Hash encoding
a(x) => :x
a(*XY) => {:* => [a(X), a(Y)]}
a(\x.A) => {:x => a(A)}


Examples;
Prefix notation,
Verbose encoding,
Brief encoding,
Hash encoding

\x.x
[:x, [:x]]
[:x, :x]
{:x => :x}

*xy
[:*, [:x], [:y]]
[:*, :x, :y]
{ :* => [:x, :y] }

xyz => **xyz
[:* [:* [:x], [:y]], [:z]]
[:*, [:*, :x, :y], :z]
{ :* => [ { :* => [:x, :y] }, :z ] }

*\x.*xy\a.*bb
-
-
{ :* => [
  { :x => {:* => [:x, :y]} }, 
  { :a => {:* => [:b, :b]} }
] }