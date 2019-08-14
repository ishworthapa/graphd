# graphd
Graph database for multi-omics data


* cd demo 

* wget https://neo4j.com/artifact.php?name=neo4j-community-3.5.8-unix.tar.gz

* tar -zxvf neo4j-community-3.5.8-unix.tar.gz

* mv *.gz neo4j-community-3.5.8/

* cd neo4j-community-3.5.8

* mkdir data/databases/demo.db

* ./bin/neo4j-import --into data/databases/demo.db/ --nodes case.nodes.gz --nodes gene.nodes.gz --nodes sample.nodes.gz --relationships case_sample.edges.gz --relationships sample_gene.edges.gz

* gunzip clinical.gz

* ./bin/neo4j start

* Open a browser and go to URL http://localhost:7474/
* Change the default password to neo4j to SOME PASSWORD.

* Edit the updateClinical.py and change the password from PASSWORD to 'SOME PASSWORD'
* python updateClinical.py -c demo/neo4j-community-3.5.8/clinical


* In the browser, Enter the query $ match p=(c:Case)-[hs:HAS_SAMPLE]-(s:Sample)-[:HAS_EXPRESSION]->(g:Gene) return p limit 5

* bin/neo4j stop
