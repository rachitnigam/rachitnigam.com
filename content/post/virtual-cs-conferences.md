+++
title = "The Cost of Virtualizing CS Conferences"
summary = "PhD student complaints about not being able to meet his friends during a global pandemic."
date = 2020-03-18T23:15:05-04:00
draft = false

tags = []

[header]
image = ""
caption = ""
preview = true

+++

Conferences in computer science are an odd occurrence. Unlike most other
research fields which primarily focus on publishing in journals, conferences
ended up being the primary publication and presentation venue in CS. They also
became the place where researchers network with each other,
learn about ongoing research, and drink beer with their grad school buddies.

Because of this, conference presentations and networking play an incredibly
important part of a junior researcher's career. Conferences allow us to show
our research to our community and have other people learn about us. In my field
of research, programming languages and systems, it takes anywhere between one
year to multiple years to complete a project. Add to that yearly deadlines and
specialized venues which results in a junior PhD student having anywhere from
two to four presentations before they go on the job market. Our recognition in
our community from our presentations and our papers is what gets us invitation
for interviews and job offers.

Unfortunately, with the outbreak of [COVID-19][covid], our world has been turned
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
I instead want to figure out how we as a community can recreate the
opportunities that conferences create for us every year. I am not an expert in
this so I will need help. I have attempted to summarize the crucial
opportunities conferences give us, what the challenges of running a virtual
conferences are, and what options we have given that physical meetings are out
of the question for a while.

### Goals of a conference

From my (second-year PhD student in a relatively small community) perspective,
conferences traditionally satisfy the following goals:

1. **Dissemination of research**: The primary goal of any conference is to allow
  researchers to present their work to their peers and discuss it.
2. **Welcoming new researchers**: The bloodline of our communities are new
  researchers. From undergrads who are attending conferences for the first
  time to PhD student presenting their research.
3. **The "Hallway" track**: Well understood to be the actual primary goal of
  any conference, the hallway track is the colloquial name for researchers
  hanging out with each other and discussing research and whatever else that
  comes to their mind. It allows us to build long term connections within our
  community.

### Options for Virtual conferences

Given that most health organizations have recommended that non-essential
travel be suspended, our only choice is to have virtual conferences in some
format. Virtual formats present several challenges:

1. **Multiple time-zones**: Since researchers are not directly traveling to
   one physical location for the conference, it's safe to assume they will
   distributed across the world in different time-zones.
2. **Lack of commitment**: As a friend of mine put it, it's hard to set aside
   the time to interact with presenters (who are possibly remote) when there
   are other commitments like teaching a class or having research meetings.
   Physical conferences act as a forcing function to set this time aside.

Both of these problems are challenging to solve. Following are some proposals
I've seen discussed/implemented at currently canceled conferences.

1. **Recorded presentations**: The bare minimum any conference can do to
   satisfy the first goal is to have authors record research talks and upload
   them to YouTube. This will allow researchers to reach out to the people who
   are most interested in their work and already know about it, but not a wider
   audience that a physical conference gives access to. It might also be
   possible to welcome new researchers through videos but they'd likely feel
   impersonal.

2. **Chatrooms for discussing papers**: In addition to uploading all the talks
   to YouTube, [ASPLOS 20][asplos-cancel] created a Slack channel to discuss
   each paper and co-located workshops. This improves the possibility of direct
   interactions by making community members available in the same place.
   Unfortunately, there really is no way of creating the hallway track in such
   a setup. As a junior student, it might be hard or impossible to get
   introductions to/talk to other researchers when they are not present in
   person. Furthermore, because of the asynchronous nature of chatrooms, it
   might be hard to have detailed conversations with people in different
   timezones.

3. **Livestreaming the conference**: Livestreaming the conference in real time
   brings the experience as close to a conference session as possible. People
   are required to commit time beforehand and ask questions to right after
   a talk. Setting this up is non-trivial owing to time zone issues. Again,
   while this provides the opportunity for more direct conversations, there
   doesn't seem to be a good way to recreate a hallway track.

4. **Postpone the conference/Merge it with another**: The nuclear option of
   pushing back the conference and waiting out the pandemic. By definition,
   this will recreate the experience of a conference. However, this would be
   incredibly hard to do since conferences are carefully planned to not overlap
   with other conferences in relevant areas. A different approach might to be
   have a bigger conference the next year and have papers from both *this year*
   and *next year* be presented there. Again, I imagine this would be a
   nightmare to organize. It also fundamentally cannot recreate opportunities
   for researchers who go on the job market this year.

None of the solutions here are perfect and I wouldn't know which one to choose.
Each of these require hard trade-offs that we, as a community, have to make.
The lack of conferences and the opportunities they create is not measurable
which makes it easier to ignore their impact. I really hope that we can
come up with a solution that is cognizant of this and takes into consideration
the people most impacted by this.

**A personal note**: I had [a paper][dahlia] accepted at PLDI 20. This
is my first first-author paper and I have been incredibly excited to present
this work for a really long time. I always imagined my first presentation
to an exciting and terrifying rite of passage that I would celebrate with
my friends, colleagues, and advisors. I feel a deep sense of loss, almost
as if all the hard work was "zeroed out" because I can't present it anymore.
I assume other people in my situation feel similarly. I don't know if senior
researchers put this much value in conference presentations (since they've
already given so many) but it seems important to acknowledge this feeling that
junior researchers have when we come up with solutions for virtual conferences.

[covid]: https://en.wikipedia.org/wiki/Coronavirus_disease_2019
[asplos-cancel]: https://asplos-conference.org/
[pldi-cancel]: https://twitter.com/PLDI/status/1240401711124090883
[iclr-cancel]: https://iclr.cc/Conferences/2020/virtual
[dahlia]: https://capra.cs.cornell.edu/dahlia

_Have comments? [Email](mailto:rachit.nigam12@gmail.com) or [tweet](https://twitter.com/notypes) at me._
