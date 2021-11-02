#!/usr/bin/python
# -*- coding: utf-8 -*-
#
# Copyright © 2020 Felix Höfling
#

from matplotlib.pyplot import axhline, figure, legend, minorticks_on, plot, savefig, text, xlabel, ylabel
from numpy import linspace, sin, exp, sqrt
from smooth_plot import smooth_plot

# read our defaults file
import defaults; defaults.set_plot_defaults()

# start a new figure
fig = figure()

x = linspace(0, 3, num=100)[1:]
y = sin(1/x) * exp(-x)
smooth_plot(x, y, num=300, deg=3)       # cubic spline interpolation

x = linspace(1, 3, num=300)
y = -sqrt(1-(x-2)**2)
l, = plot(x, y, lw=0.5, label="hi-res half circle")

x = linspace(1, 3, num=6)
y = -sqrt(1-(x-2)**2)
plot(x, y, 'o', color=l.get_color())                        # show data points

plot(x, y, label="straight lines")                          # connect data points
smooth_plot(x, y, num=100, deg=3, label="cubic spline")     # cubic spline interpolation

xlabel(r"$x$")
ylabel(r"$y$")
legend()

text(0.4, 0.7, r"$\sin(1/x)\mathrm{e}^{-x}$")

axhline(0, color='k', ls='-', lw=0.5, zorder=1)
minorticks_on()

savefig("example.pdf")

