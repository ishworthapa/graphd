#!/usr/bin/python

######################################################################
# updateClinical.py                                                  #
# Author:  Ishwor Thapa                                              #
######################################################################



import glob
import sys
import gzip
import argparse
import re
import math
from neo4j.v1 import GraphDatabase, basic_auth


######################################################################
# parse tsv file and update graph database with clinical info.       #
######################################################################

def processClinical(driver, clinicalDir):
    #system_version is stage_system_version
    #bcr_patient_barcode

    session = driver.session()
    clinicalFiles = glob.glob(clinicalDir+"/*/*.tsv")

    for tsvFile in clinicalFiles:
        tagValue = {}
        barcode = None
        with open(tsvFile, 'r') as f:
            for line in f.readlines():
                line = line.strip()
                tag1, tag2, value = line.split("\t")
                tag2 = tag2.split(":")[1]
                if tag2 is "system_version":
                    tag2 = "stage_system_version"
                tagValue[tag2] = value

        parameter_dict = {'params':tagValue}
        barcode = tagValue['bcr_patient_barcode']
        query = "MATCH (case:Case) where case.patient_barcode = '" + barcode + "' set case += {params}"

        print(query)
        #print(session.run("MATCH(case:Case) where case.patient_barcode = '" + barcode+"' return case"))
        status = session.run(query, parameters = parameter_dict)
        print(status)


    session.close()
    return



######################################################################
# main program                                                       #
######################################################################

if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('-c','--clinicalDir')
    args = parser.parse_args()
    print(args.clinicalDir)
    driver = GraphDatabase.driver("bolt://localhost:7687", auth=basic_auth("neo4j", "PASSWORD"))
    cdirs = args.clinicalDir.split(',')
    for i in range(len(cdirs)):
        processClinical(driver, cdirs[i])
