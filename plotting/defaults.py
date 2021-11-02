#!/usr/bin/env python
# -*- coding: utf-8 -*-
#
# Copyright © 2020 Felix Höfling
#

def set_plot_defaults():
    """
    set matplotlib defaults
    """

    from pylab import rc, cycler
    from palette import LondonUnderground_Colours

    # all possible keys are shown with matplotlib.rcParams.keys()

    rc('font', **{'family' : 'sans-serif', 'sans-serif' : ['lmss'], 'size' : 10})
    rc('text', usetex=True)
    rc('text.latex', preamble=(
        r'\usepackage{textcomp}',
        r'\usepackage{amsmath}',
        r'\usepackage[T1]{fontenc}',
        r'\usepackage{times}',
#        r'\usepackage[scaled]{helvet} \renewcommand{\familydefault}{\sfdefault}',
        r'\usepackage{lmodern} \renewcommand{\familydefault}{\sfdefault}',
#        r'\usepackage[lite,eucal,subscriptcorrection,slantedGreek,zswash]{mtpro2}',
#        r'\usepackage[mtphrb,mtpcal,subscriptcorrection,slantedGreek,zswash]{mtpro2}',
#        r'\usepackage{txfonts}', # alternative if MathTimePro II fonts are not installed
#        r'\usepackage{lmodern}',  # another alternative font family
        ))
    rc('legend', frameon=False, numpoints=1, fontsize='small',
        labelspacing=0.2, handlelength=1, handletextpad=0.5, borderaxespad=0.5)
    rc('figure', figsize=(3.4, 2.4))  # gnuplot standard is (5, 3.5)
    rc('axes', linewidth=.7,
        prop_cycle=cycler(color=LondonUnderground_Colours.color_cycle))
    rc('axes.formatter', use_mathtext=False)

    rc('lines', linewidth=1, markersize=3, markeredgewidth=0)
    rc('xtick', direction='in', top=True)
    rc('ytick', direction='in', right=True)
    rc('savefig', bbox='tight', pad_inches=0.05, dpi=600, transparent=False)
    # http://www.scipy.org/Cookbook/Matplotlib/UsingTex
    rc('ps', usedistiller='xpdf')

