#!/usr/bin/python
# -*- coding: utf-8 -*-
#
# Copyright © 2020 Felix Höfling
#

from matplotlib.pyplot import axhline, figure, minorticks_on, plot, savefig, text, xlabel, ylabel
from numpy import linspace, sin, exp
from smooth_plot import smooth_plot

# read our defaults file
import defaults; defaults.set_plot_defaults()

# start a new figure
fig = figure()

x = linspace(0, 3, num=100)[1:]
y = sin(1/x) * exp(-x)
smooth_plot(x, y, num=300, deg=3)       # cubic spline interpolation

xlabel(r"$x$")
ylabel(r"$y$")

text(0.4, 0.7, r"$\sin(1/x)\mathrm{e}^{-x}$")

axhline(0, color='k', ls='-', lw=0.5, zorder=1)
minorticks_on()

savefig("example.pdf")

