+++
title = "HULA: Load Balancing for Programmable Data Planes"
date = 2018-12-14T14:19:37+05:30
draft = true

[extra]
summary = "PL student implements something useful, surprising everyone involved."
tags = []

+++

> I am not a networking expert

HULA is a load balancing algorithm that leverages the new primitives offered
by Software Defined Networks (SDNs). Specifically, it targets programmable
switches and uses the P4 programming language to implement algorithm entirely
in the data plane part of the network, allowing it be more responsive compared
to control plane alternatives.

### What is load balancing?

In networking, load balancing is the problem of equally distributing work across
_n_ replicated servers. In the following network, the switch `S` is distributing
connections from `I` to the three replicated nodes `h1`, `h2`, and `h3`.

![load balancing animation](/img/load-balance.gif)

An orthogonal balancing problem in networks is efficient utilization of links.
While the link utilization metrics differ depending on the network characteristics
[^1], one common goal is to minimize per-link utilization. For example, the
following network, we're distributing data from `I` on two different paths to
minimize the amount of traffic on either link.

![link utilization animation](/img/link-balance.gif)

The canonical solution to this balancing problem is using the Equal-cost
multi-path (ECMP) routing algorithm. ECMP spreads traffic uniformly across
multiple best paths to a given host. However, ECMP suffers from several problems
in practice:

1. ECMP is usually not performed at the packet level to preserve the packet
   ordering. Instead, routers usually associate a path to a particular "flow".
   A flow is simply the hash of the source and destination headers in a packet.
   However, this means that a large flow would cause over utilization of a
   particular link as time goes on.
2. ECMP requires the control plane to calculate the best paths in the network
   and reconfigure the forwarding tables on the routers. This forms a very slow
   control loop -- by the time the network state is updated, the link utilization
   characteristics might be very different.

[^1]: A network trying to be robust against network failures might instead
