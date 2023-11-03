#!/usr/bin/sage
#
# write a sage math script to plot the motion of a double pendulum with
# equal point masses and equal length strings, assuming no friction, no
# drag

import numpy as np
from scipy.integrate import solve_ivp
import matplotlib.pyplot as plt

# Physical constants
g = 9.81  # acceleration due to gravity
L = 1.0  # length of pendulum
m = 1.0  # mass at pendulum end

# System of differential equations
def double_pendulum(t, y):
    theta1, z1, theta2, z2 = y
    c, s = np.cos(theta1-theta2), np.sin(theta1-theta2)
    theta1_dot = z1
    z1_dot = (m*g*np.sin(theta2)*c - m*s*(L*z1**2*c + L*z2**2) -
              (m+1)*g*np.sin(theta1)) / L / (1 + m*s**2)
    theta2_dot = z2
    z2_dot = ((m+1)*(L*z1**2*s - g*np.sin(theta2) + g*np.sin(theta1)*c) + 
              m*L*z2**2*s*c) / L / (1 + m*s**2)
    return theta1_dot, z1_dot, theta2_dot, z2_dot

# Time array
t = np.linspace(0, 10, 1000)

# Initial conditions: theta1, theta1_dot, theta2, theta2_dot
y0 = [np.pi/4, 0, np.pi/2, 0]

# Solve system of differential equations
bunch = solve_ivp(double_pendulum, [0,10], y0, max_step=0.1)

y = bunch.y
t = bunch.t

# Unpack theta1 and theta2
theta1, theta2 = y[:,0], y[:,2]

# Convert to Cartesian coordinates
x1 = L * np.sin(theta1)
y1 = -L * np.cos(theta1)
x2 = x1 + L * np.sin(theta2)
y2 = y1 - L * np.cos(theta2)

# Plot the motion of the double pendulum
plt.figure(figsize=(6,6))
plt.plot(x1, y1, 'ro', label='Mass 1')
plt.plot(x2, y2, label='Mass 2')
plt.xlabel('x')
plt.ylabel('y')
plt.legend()
plt.grid(True)
plt.show()
