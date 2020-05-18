LOAD CSV WITH HEADERS FROM "file:///all.cnv.case.sample.csv" AS row
MERGE (s:Sample {sample_barcode:row.sample_barcode})
RETURN count(*);

LOAD CSV WITH HEADERS FROM "file:///all.cnv.case.sample.csv" AS row
MATCH (c:Case {patient_barcode:row.patient_barcode})
MATCH (s:Sample {sample_barcode:row.sample_barcode})
MERGE (c)-[:HAS_SAMPLE{sample_type:row.sample_type}]->(s) 
RETURN (count(*));

LOAD CSV WITH HEADERS FROM "file:///all.cngain.csv" AS row
MERGE (g:Gene {symbol:row.symbol})
RETURN count(*);

LOAD CSV WITH HEADERS FROM "file:///all.cnloss.csv" AS row
MERGE (g:Gene {symbol:row.symbol})
RETURN count(*);

LOAD CSV WITH HEADERS FROM "file:///all.cngain.csv" AS row
MATCH (s:Sample {sample_barcode:row.sample_barcode})
MATCH (g:Gene {symbol:row.symbol})
MERGE (s)-[:HAS_COPYGAIN]->(g)
RETURN count(*);

LOAD CSV WITH HEADERS FROM "file:///all.cnloss.csv" AS row
MATCH (s:Sample {sample_barcode:row.sample_barcode})
MATCH (g:Gene {symbol:row.symbol})
MERGE (s)-[:HAS_COPYLOSS]->(g)
RETURN count(*);

