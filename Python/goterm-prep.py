#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Tue Dec 19 10:30:22 2017

@author: Elinor
"""

from os import chdir, getcwd
import pandas as pd

# set directory when working in spyder
wd = getcwd()
chdir(wd)


path = '../cyano_light/Cyanoproteins/input/goterm.txt'
out = '../cyano_light/Cyanoproteins/input/goterm_structure2.csv'

df = pd.read_csv(path, sep = "\t")

df.to_csv(out, sep = "\t")