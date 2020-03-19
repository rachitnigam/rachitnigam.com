+++
title = "Organizing a Virtual CS Conference"
summary = "Our worlds are shattered"
date = 2020-03-18T23:15:05-04:00
draft = false

authors = []
tags = []

# Featured image
# Place your image in the `static/img/` folder and reference its filename below, e.g. `image = "example.jpg"`.
# Use `caption` to display an image caption.
#   Markdown linking is allowed, e.g. `caption = "[Image credit](http://example.org)"`.
# Set `preview` to `false` to disable the thumbnail in listings.
[header]
image = ""
caption = ""
preview = true

+++

Conferences in computer science are an odd occurrence. Unlike most other
research fields which primarily focus on publishing in journals, conferences
are the primary way for research to discuss and disseminate their research.
They are also the primary way for researcher to network with each other,
learn about ongoing research, and drink beer with their grad school buddies.

This makes conference presentations an incredibly important part of a junior
researchers career. Conferences allow us to show our research to our community
and have other people learn about us. In my field of research, programming
languages and systems, it takes anywhere between one year to multiple years to
complete a project. Add to that yearly deadlines and specialized venues which
results in a junior PhD student having anywhere from two to four presentations
before they go on the job market. Our recognition in our community, from our
presentations and our papers is what gets us invitation for interviews and
job offers.

Unfortunately, with the outbreak of [COVID-19][covid], our worlds have been turned
upside down. Beyond the incredible amounts of fear, uncertainty, and human
suffering it has caused, it has also destroyed one of the core mechanisms of
conducting science---meeting people. Multiple major academic conferences
([ASPLOS][asplos-cancel], [ICLR][iclr-cancel], [PLDI][pldi-cancel]) have been canceled. Junior researchers, who had
decided to go on job markets, find internships, or visit another institutions
have had to cancel all of their plans. The impact of these things is
unquantifiable---how does one measure the effect of a missed serendipitous
research collaboration, or that one person on a hiring committee hearing about
your work?

However, I am not here to complain about missed conferences. Canceling
conferences in the midst of a global pandemic is *the right thing* to do.
I instead what to figure out how we as a community can recreate the
opportunities that conferences have created for us. I am not an expert in this
so I will need help. I have attempted to summarize the crucial opportunities
conferences give us and what options we have given that physical meetings are
out of question for a while.

### Goals of a conference

From my (second year PhD student in a relatively small community) perspective,
conferences traditionally satisfy the following goals:

1. **Dissemination of research**: The primary goal of any conference is to allow
  researchers to present their work to their peers and discuss it.
2. **Welcoming new researchers**: The bloodline of our communities are new
  researchers. From undergrads who are attending conferences for the first
  time to PhD student presenting their research.
3. **The "Hallway" track**: Well understood to be the actual primary goal of
  any conference, the hallway track is the colloquial name for researchers
  hanging out with each other and discussing research and whatever else that
  comes to their mind.

### Options for Virtual conferences

Given that most health organizations have recommended that non-essential
travel be suspended, our only choice is to have virtual conferences in some
format. Virtual formats present several challenges:

1. **Multiple time-zones**: Since researcher are not directly traveling to
   one physical location for the conference, it's safe to assume they will
   distributed across the world in different time-zones.
2. **Lack of commitment**: As a friend of mine put it, it's hard to set aside
   the time to interact with presenters (who are possible remote) when there
   are other commitments like teaching a class or having research meetings.
   Physical conferences act as a forcing function to set this aside time.

Following are some proposals I've seen discussed/implemented:

1. **Recorded presentations**: The bare minimum any conference can do to
   satisfy the first goal is to have authors record research talks and upload
   them to YouTube. This will allow researchers to perhaps reach out to the
   people who are most interested in their work and are already interested
   in it, but nothing beyond that. It might also be possible to welcome new
   researchers through videos but they'd likely feel impersonal.

2. **Chatrooms for discussing papers**: In addition to uploading all the talks
   to YouTube, [ASPLOS 20] created a slack channel to discuss each paper and
   each co-located workshop. This has the benefit of allowing more interactions
   with researchers by asking questions. While this improves on the first
   design, there really is no way of creating the hallway track is such a setup.
   As a junior student, it might be hard to cold DM someone you where looking
   forward to talking to but don't already know. Furthermore, because of the
   asynchronous nature of chatrooms, it might be hard to have detailed
   conversations with people.

3. **Livestreaming the conference**: Livestreaming the conference in real time
   brings the experience as close to a conference session as possible. People
   are required to commit time beforehand and ask questions to right after
   a talk. Setting this up is non-trivial owing to time zone issues. Again,
   while this provides the opportunity for more direct conversations, there
   doesn't seem a good way to recreate a hallway track.

4. **Postpone the conference**: The nuclear option of pushing back the
   conference and waiting out the pandemic. By definition, this will recreate
   the experience of a conference. However, this would be incredibly hard to
   do since conferences are carefully planned to not overlap with other
   conferences in relevant areas. A different approach might to be have a
   bigger conference the next year and have papers from both *this year* and
   *next year* be presented there. Again, I imagine this would be a nightmare
   to organize.

None of the solutions here are perfect and I wouldn't know which one to choose.
Each of these require hard trade-offs that we, as a community, have to make.
The lack of conferences and the opportunities they create is not measurable
which makes it easier to ignore their impact. I really hope that we can
come up with a solution that is cognizant of them.

**A short personal note**: I had [a paper][dahlia] accepted at PLDI 20. This
is my first first-author paper and I had been incredibly excited to present
this work for a really long time. I always imagined my first presentation
to an exciting and terrifying rite of passage that I would celebrate with
my friends, colleagues, and advisors. I feel a deep sense of loss, almost
as if all the hard work was "zeroed out" because I can't present it anymore.
I assume other people in my situation feel similarly. I don't know if senior
researchers put this much value in conference presentations (since they've
already given so many) but it seems important to acknowledge this when we
come up with solutions.

[covid]: https://en.wikipedia.org/wiki/Coronavirus_disease_2019
[asplos-cancel]: https://asplos-conference.org/
[pldi-cancel]: https://twitter.com/PLDI/status/1240401711124090883
[iclr-cancel]: https://iclr.cc/Conferences/2020/virtual
[dahlia]: https://capra.cs.cornell.edu/dahlia

_Have comments? [Email](mailto:rachit.nigam12@gmail.com) or [tweet](https://twitter.com/notypes) at me._
