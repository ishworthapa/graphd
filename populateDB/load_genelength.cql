LOAD CSV WITH HEADERS FROM "file:///gene.symbol.length.csv" AS row
MATCH (g:Gene {symbol:row.symbol})
SET g.length = toInt(row.length)
RETURN count(*);
