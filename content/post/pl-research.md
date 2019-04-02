+++
title = "Don't be Programming Languages researchers"
summary = "A pointless diatribe about PL research"
date = 2018-09-22T21:52:05-04:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["rambling", "research"]
categories = []

# Featured image
# Place your image in the `static/img/` folder and reference its filename below, e.g. `image = "example.jpg"`.
[header]
image = ""
caption = ""

+++

*Instead of being a judgement of what PL research should be, this short post is
simply a reflection of my research interests and what role PL plays into it.*

During a recent PLDG talk, the speaker said, "I think that, as a community, PL
people have a moral responsibility to step in and say, No, you're having fun
wrong!" While I have no qualms about the comment itself (researchers should be
able to not take themselves seriously sometimes), it led me to think about the
way PL research is applied in new domains. The speaker usually starts with an
overview of the domain and talks about the current state of the art of
programming languages and tools in it. They then go on to point out that most
tools and languages fail to make use of some amazing and well known PL
technique. Then they describe their work which applies the aforementioned PL
technique and build cool and interesting language abstractions with the promise
of building better and improved tools for the domain.

While I strongly endorse PL techniques and research being applied in new
domains, this story demonstrates a fundamental issue for me: Application of PL techniques is
done retrospectively. PL researchers are not there when a domain is shaping up
and people trying to build tools and programming languages for that domain.
Only once people have made build these tools, which in turn cement
themselves into domain, do PL researchers come into the scene and apply their
cool techniques.

So here is my solution: We should stop being PL researchers. Or put in a more
nuanced manner, PL researchers should take it upon themselves to specialize
heavily into new domains and apply PL techniques in those domains. Programming
languages are the most fundamental way of communicating intent to computers. As
PL researchers, we should be helping people from other domains to do this
exactly.
