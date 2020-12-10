#!/usr/bin/env python
# -*- coding: utf-8 -*-
#
# Copyright © 2020 Felix Höfling
#

def smooth_plot(x, y, fmt="-", deg=2, num=200, **kwargs):
    """
    Compute a spline interpolation of given degree from the data points and
    plot the function on the given number of sample points.
    """
    from numpy import amin, amax, linspace
    from scipy.interpolate import InterpolatedUnivariateSpline
    from matplotlib.pyplot import plot

    y_smooth = InterpolatedUnivariateSpline(x, y, k=deg)
    x_ = linspace(amin(x), amax(x), num=num)
    return plot(x_, y_smooth(x_), fmt, **kwargs)


def smooth_logplot(x, y, fmt="-", deg=2, num=200, **kwargs):
    """
    Compute a spline interpolation of given degree from the data points and
    plot the function on the given number of sample points, equidistantly
    spaced on a logarithmic axis.
    """
    from numpy import amin, amax, log10, logspace
    from scipy.interpolate import InterpolatedUnivariateSpline
    from matplotlib.pyplot import plot

    y_smooth = InterpolatedUnivariateSpline(x, y, k=deg)
    x_ = logspace(log10(amin(x)), log10(amax(x)), num=num)
    return plot(x_, y_smooth(x_), fmt, **kwargs)

