
LOAD CSV WITH HEADERS FROM "file:///all.slides.url.csv" AS row
MATCH (s:Sample {sample_barcode:row.sample_barcode})
MERGE (t:Slide {url:row.slide_url})
MERGE (s)-[:HAS_IMAGE]->(t)
RETURN count(*);

