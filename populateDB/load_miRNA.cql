LOAD CSV WITH HEADERS FROM "file:///all.mirna.case.sample.csv" AS row
MERGE (s:Sample {sample_barcode:row.sample_barcode})
RETURN count(*);

LOAD CSV WITH HEADERS FROM "file:///all.mirna.case.sample.csv" AS row
MATCH (c:Case {patient_barcode:row.patient_barcode})
MATCH (s:Sample {sample_barcode:row.sample_barcode})
MERGE (c)-[:HAS_SAMPLE{sample_type:row.sample_type}]->(s) 
RETURN (count(*));

LOAD CSV WITH HEADERS FROM "file:///all.mirna.names.csv" AS row
MERGE (m:miRNA {name:row.miRNA})
RETURN count(*);

LOAD CSV WITH HEADERS FROM "file:///all.mirna.data.csv" AS row
MATCH (s:Sample {sample_barcode:row.sample_barcode})
MATCH (g:miRNA {name:row.miRNA})
MERGE (s)-[:HAS_READS{RPM:toFloat(row.RPM)}]->(g)
RETURN count(*);
