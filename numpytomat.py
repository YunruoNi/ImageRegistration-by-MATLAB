# -*- coding: utf-8 -*-
"""
Spyder Editor

This is a temporary script file.
"""
#import os

import numpy as np
from scipy.io import savemat

a = np.load('/Users/n.y.r/Desktop/Fixed.npy')
savemat('Fixed.mat', {'mri':a})

# a to mat
# save mat
